% extract spectrotemporal pattern of each syllable
addr = 'speech signal';
SNR = 25;
% sylb_ID = 'ace';
clear STo STa I

slist = {'aa', 'eis', 'eve', 'fair', 'geim', 'gli', 'in', 'ind', ...
    'is', 'jo', 'ker', 'laod', 'more', 'naf', 'ning', 'nis', 'noiz', ...
    'po', 'prai', 'ru', 'sbrint', 'shaap', 'sur', 'tai', 'te', 'the', 'un', 'wan', ...
    'wins', 'zat', 'zing', '-'};
Ns = length(slist);
win = 25*8; % samples per gamma unit
I = cell(1, Ns);
ST_noise_25 = zeros(6, 8*25, Ns);
for ks = 1:Ns-1
    sylb_ID = slist{ks};
    STo = get_aud_spectrogram(sylb_ID, addr, SNR);
    Lchunk = floor(size(STo, 2))/win;
    STa = zeros(6, win);
    for k = 1:win
        STa(:, k) = mean(STo(:, (k-1)*Lchunk+1: k*Lchunk), 2);
    end   
    sbound = [1; length(STo)];
    I_temp = get_syl_parameters(STo, sbound);
    I{ks} = I_temp{1};
    ST_noise_25(:, :, ks) = STa;
end
