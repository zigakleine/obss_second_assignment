records = ["100" "101" "102" "103" "104" "105" "106" "107" "108" "109" "111" "112" "113" "114" "115" "116" "117" "118" "119" "121" "122" "123" "124" "200" "201" "202" "203" "205" "207" "208" "209" "210" "212" "213" "214" "215" "217" "219" "220" "221" "222" "223" "228" "230" "231" "232" "233" "234"];
records2 = ["100" "101" "102" "103" "104" "105" "106" "108" "112" "113" "114" "115" "116" "117" "119" "121" "122" "123" "200" "201" "202" "203" "205" "208" "209" "210" "212" "213" "215" "217" "219" "220" "221" "222" "223" "228" "230" "231" "233" "234"];
% weird signals: 107, 109, 111, 118, 124, 207, 214, 232

for i=1:length(records2)
    base_file_name = records2(i);
    Classifier(base_file_name);
end