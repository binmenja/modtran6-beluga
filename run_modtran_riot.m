%%%%%%% This is an example file
%%%%%%% Benjamin Riot--Bretecher (benjamin.riotbretecher@mail.mcgill.ca), Jul 10, 2023
path_modtran='/project/rrg-yihuang-ad/binmenja/models/modtran6/bin/linux/';  %% please change this line to your own data directory
file_profile = '/home/binmenja/projects/rrg-yihuang-ad/binmenja/models/modtran6/nsa_analysis/profile_sonde_202002.mat'
load(file_profile)
format long
resolution = 0.4821472; %cm-1
cloud.qi = []; % NO CLOUD
cloud.ql = [];% NO CLOUD
cloud.z = [];% NO CLOUD
fwhm = resolution.*2; % NEED TO READ
v1 = 400.18219;
v2 = 1799.8555;
angle = 180; % 180 IS ZENITH ANGLE SO 180 DEGREES IS GROUND TO SPACE
emis= 0.3; % IMPORTANT   
iLoc = '0';

for i =1:size(profile.z,2)
    disp(i)
    %system('rm test_riot.tp5');
    %disp(profile.nlyr)
    clear zt ts z p t q
    z = profile.z(:,i);
    p = profile.p(:,i);
    %disp(p)
    q = profile.q(:,i);
    t = profile.t(:,i);
    nlyr = size(z,1)-1;
    co2(:) = zeros(nlyr+1,1) + 400;
    o3(:) = zeros(nlyr+1,1);
    zt = z(end);
    ts = profile.ts(i);
    mode_sun = 0; % Sun mode -  see table 3.3
    disp('modtran6 maker')
    modtran6_tape5_make_brb(path_modtran,nlyr,z,p,t,q,co2,o3,resolution,fwhm,cloud,v1,v2,angle,iLoc,emis,zt,ts);
    %modtran6_airs_tape5_make_cld_profile(path_modtran,profile.nlyr,profile.z,profile.p,profile.t,profile.q,profile.co2,profile.o3,resolution,fwhm,cloud,v1,v2,angle,iLoc,emis,zt,ts);

    %% removes existing tapes
   % system('rm test_riot.chn');
    disp('tape5 saved')
    system('rm mlw.plt');
    %system('rm 202002.tp8');

    %% calls modtran6 to run
    system([path_modtran,'tp5tojson mlw.tp5 2> error1.log']);
    system([path_modtran,'mod6c_cons mlw.json 2> error2.log']); %% *.json is the 'new version' input file generated by the tape5 maker. mod6c_cons is the executable
    %system([path_modtran,'mod6c_cons mlw.tp5 2> error2.log']);
    disp('written')
    [spectra.wavnum_plt(:,i), spectra.rad_plt(:,i)] = read_pltout(strcat(path_modtran,'mlw.plt'));
    spectra.date(i) = profile.date(i);
    [~, ~, ~, ~, ~, ~, ~, ~, ~, ~, spectra.rh(i,:), ~, ~, ~] = read_data_with_header('mlw.tp6') 
end
save('spectra_sonde_nsa_202002_t1m1.mat','spectra','-v7.3');
%%plot(wavnum_plt, rad_plt, LineWidth=0.5);
%xlabel('Wavenumber');
%ylabel('Radiance');
%saveas(gca,'latest_run_riot.jpg');
%disp('Plot saved! - latest_run_riot.jpg');
%% read outputsi
%addpath('/home/binmenja/projects/rrg-yihuang-ad/binmenja/models/modtran6/nsa_analysis/')
%[wavenum, rad] =read_channels('test_riot.chn',6);  %% mlw.chn is the outputfile; 6 for specifying the version of modtran.
