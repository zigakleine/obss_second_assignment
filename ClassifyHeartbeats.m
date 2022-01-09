
function [beatPredictions, predictionsStr] = ClassifyHeartbeats(beats, count, signals)

    %disp(beats);
    %disp(count);
    %disp(size(signals));
      
    signalsSize = size(signals);    
    signalSum = zeros(1, signalsSize(2));
    
    numOfSignals = signalsSize(1);
    
    for sigNum=1:numOfSignals

        signal = signals(sigNum,:);
        signalSum = signalSum + signal;
    end
    
    avgSig = signalSum/numOfSignals;
    signal = avgSig;
    
    %odstrani baseline drift --> filter signal —> flip signal --> filter
    %signal --> flip signal

    % najdi povprečni normalni (N) srčni utrip v prvih 5 minutah posnetka 
    % s pomočjo sigavg wftdb funkcije od -60 do +100 ms za vsak zaznan N stčni utrip

    % iteriraj čez vse utripe:
        % vzami -60 do +100 samplov za vsak utrip in izračunaj podobnost z našim povprečnim utripom
        % klasificiraj glede na nek threshold
        % dinamičen prag??
        
    Fc = 0.8;
    Fs = 360;
        
    [b, a] = butter(4, Fc/(Fs/2), "high");
   
    fsig = filter(b, a, signal);
    
    fsig_flip = flip(fsig);
    
    ffsig_flip = filter(b, a, fsig_flip);
    
    ffsig = flip(ffsig_flip);
   
    %plot(signal); hold on; plot(ffsig);
   
    indexMinus = int32(0.06 * Fs);
    indexPlus = int32(0.1 * Fs);
    %disp(indexMinus + indexPlus);
    
    %command = 'echo "hello"';
    %[status,cmdout] = system(command);
    %disp(cmdout);
    
    %avgBeat = dlmread("./mitdb/100avg.txt");
    %avgBeat = avgBeat(:, 2);
    %avgBeat = avgBeat*200;

    first5MinSamples = 5*60*Fs;
    
    avgHeartbeatSum = zeros(1, (1+indexMinus+indexPlus));
    numOfHeartbeatsInFirst5Min = 0;
    
    for i=1:count
        currentBeatIndex = beats(i, 1);
        if currentBeatIndex < first5MinSamples && beats(i, 2) == 0
            avgHeartbeatSum = avgHeartbeatSum + ffsig(currentBeatIndex-indexMinus:currentBeatIndex+indexPlus);
            numOfHeartbeatsInFirst5Min = numOfHeartbeatsInFirst5Min + 1;
        end
    end
    
    avgHeartbeat = avgHeartbeatSum/numOfHeartbeatsInFirst5Min;
    %plot(avgHeartbeat); hold on;  plot(avgBeat);
    
    %heartbeatLen = size(avgHeartbeat);
    %heartbeatLen = heartbeatLen(2);
    
    predictions = zeros(1, count);
    predictionsStr = repmat(" ", 1, count);
    
    for i=1:count
       
        currentBeatIndex = beats(i, 1);
            
        if currentBeatIndex-indexMinus < 1
            indexLeft = 1;
            appendLeft = zeros(1, 1-(currentBeatIndex-indexMinus));
        else
            indexLeft = currentBeatIndex-indexMinus;
            appendLeft = [];
        end
        
        if currentBeatIndex+indexPlus > signalsSize(2)
            indexRight = signalsSize(2);
            appendRight = zeros(1, (currentBeatIndex+indexPlus - signalsSize(2)));
        else
            indexRight = currentBeatIndex+indexPlus;
            appendRight = [];
        end
        
        currentHeartbeat = [ appendLeft, ffsig(indexLeft:indexRight), appendRight];
        %disp(size(currentHeartbeat));
        
        % now just compare currentHeartBeat to avgHeartbeat
        dist = d2(currentHeartbeat, avgHeartbeat);
        disp(dist + " " + beats(i, 2));
        
        if dist > 50
            predictions(i) = 1;
            predictionsStr(i) = "V";
        else
            predictions(i) = 0;  
            predictionsStr(i) = "N";            
        end
        
    end
   
    
    disp("!!!!!!!!!");

    beatPredictions = [beats, predictions'];
    predictionsStr = predictionsStr';
    
    disp(beatPredictions);
        
        
        