function dist = d2(heartbeat1, heartbeat2)

    heartbeatLength = size(heartbeat1);
    heartbeatLength = heartbeatLength(2);
    
    %disp(heartbeatLength);
    distSum = 0;
    
    for i=1:heartbeatLength
        distSum = distSum + (abs(heartbeat1(i) - heartbeat2(i)))^2;
    end
    
    distAvg = (1/heartbeatLength)*(distSum);
    distAvgRoot = sqrt(distAvg);
    dist = distAvgRoot;
    