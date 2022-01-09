function Classifier(record)

  fileNameTxt = sprintf('./mitdb/%s.txt', record);
  
  fileNameMat = sprintf('./mitdb/%sm.mat', record);
  t=cputime();
  [beats, count] = readannotations(fileNameTxt);
  file = load(fileNameMat);
  
  [beatPredictions, predictionsStr] = ClassifyHeartbeats(beats, count, file.val);
  
  fprintf('Running time: %f\n', cputime() - t);
  
  asciName = sprintf('./detections/%s.asc',record);
  fid = fopen(asciName, 'wt');
  
  
  for i=1:size(beatPredictions, 1)
    fprintf(fid,'0:00:00.00 %d %s 0 0 0\n', beatPredictions(i, 1), predictionsStr(i));
  end
  fclose(fid);

  % Now convert the .asc text output to binary WFDB format:
  % wrann -r record -a qrs <record.asc
  % And evaluate against reference annotations (atr) using bxb:
  % bxb -r record -a atr qrs
end

