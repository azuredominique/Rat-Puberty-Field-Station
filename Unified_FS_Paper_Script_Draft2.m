%% Unified Field Station Figure Script 5/24/21

 
%% Figure 1 Fecal Estradiol, Testosterone, and fE2 rise day vs. VO or Prepuptial Separation
%Figure 1C-F Average Female Profile by Cycle of Life

%Early Life 2 Days
CycleTwoDayEarlyLife2429=[2553.25342 3876.084242;1906.982696 3008.455834; 2188.013065 5710.116289;3668.106965 3846.092366;850.3057331 1153.338599;1259.53322 1310.900611;...
  972.36837 2090.037396];

% Pre VO Data
%skipped 8 no data
CyclePreVO=[7391.462981 3788.075424 8197.59987 4633.706742; 4691.130712 3172.745848 4521.68797 2504.171089;4398.989257 6203.796158 3421.17423 4807.164688; 2171.18442 1887.265548 4845.788199 1939.846803;...
1573.681995 2356.690191 2127.050395 6302.812812;1012.72079 1048.083952 915.7903447 1131.934989; 2709.249 2709.249 2874.137 2835.847];

% First Cycle Pos VO
CycleFirstVO=[4633.706742 5187.25474 6978.58898 4206.903535; 2885.231857 2826.180639 4869.305675 1808.175; 3421.17423 4807.164688 3160.345185 5868.651632;...
4035.797 5267.515463 9448.50346 6659.652692;3003.043216 993.4375096 2516.090731 1904.576023;1678.847816 2805.522688 4203.6504 3768.970749; 570.3255263 1280.208077 2036.122481 1950.339843;...
2835.847 2203.42 3082.26 3247.77];

%Mid puberty cycle E2 (try to match pp43-49) / Chose by Day of Life
CycleMidPuberty=[4691.130712 6415.907408 8848.030667 6596.394685;NaN 1808.175132 5121.458222 2915.386225;7057.072611 6291.556352 4869.550519 5338.021283;...
  1929.361609 4510.729903 5788.659474 7057.072611; 1904.576023 2109.992423 2300.967003 1541.656014; 9233.261719 3689.363215 1967.102494 5050.933506];
  
E2p46=[4691.130712 1808.175132 3095.796347 3728.881652 1904.576023 7057.072611 1929.361609 NaN];
E2p47=[6415.907408 5121.458222 9233.261719 1885.175167 2109.992423 6291.556352 4510.729903 NaN];
E2p48=[8848.030667 2915.386225 3689.363215 4497.232022 2300.967003 4869.550519 5788.659474 NaN];
E2p49=[6596.394685 NaN 1967.102494 4497.232022 1541.656014 5338.021283 7057.072611 NaN];

CycleMidPubertyAlternate=[E2p46',E2p47',E2p48',E2p49']

%Late puberty try to match p55-61)
CycleLatePuberty=[5681.577089 3349.450803 6689.22706 10042.84604;4749.524579 5462.222933 5913.057365 7391.462981; 4685.557819 6117.662615 9150.04943 7376.161285;7952.181114 3939.420753 8199.40752 3846.092366;...
2647.472557 3205.286455 3668.661871 3350.465329; 2526.9117 1869.342162 3935.244889 3158.64079;2832.860684 2108.434808 2778.537877 1261.45796;3521.902 3858.248 4508.509 3784.649];

% Statistics for Females
% 1) Does E2 Rise over life (AUC of each individual for each time point KW)
% - No

AUCpprecycle=trapz(CyclePreVO,2);size(AUCpprecycle)
AUCpfirstcycle=trapz(CycleFirstVO,2);size(AUCpfirstcycle)
AUCpmidcycle=trapz(CycleMidPubertyAlternate,2);size(AUCpmidcycle)
AUCplatecycle=trapz(CycleLatePuberty,2);size(AUCplatecycle)

groupauc(1:7)=1; groupauc(8:15)=2;
groupauc(16:23)=3; groupauc(24:31)=4;
[pE2,tblpE2,statspE2]=kruskalwallis([AUCpprecycle' AUCpfirstcycle' AUCpmidcycle' AUCplatecycle'],groupauc)
multcompare(statspE2)
%Source     SS      df     MS      Chi-sq   Prob>Chi-sq
%------------------------------------------------------
%Groups    233.17    3   77.7222    3.22      0.3595   
%Error    1796.83   25   71.8733                       
%Total    2030      28                                                               

groupfirstvlast(1:7)=1;groupfirstvlast(8:15)=2;
[pE2,tblpE2,statspE2]=kruskalwallis([AUCpprecycle' AUCplatecycle'],groupfirstvlast)
%p=0.203; E2 does not rise significantly over life. You only get
%significant elevations by cycle

% Day 3, presumed proestrus estradiol peak, is higher than hormonal
% diestrus (day 1)
% The natural question is then : are these day 3's higher than day 1's
CycleDay3sAfterPubOnset=[CycleFirstVO(:,3)' CycleMidPubertyAlternate(:,3)' CycleLatePuberty(:,3)'];
CycleDay1sAfterPubOnset=[CycleFirstVO(:,1)' CycleMidPubertyAlternate(:,1)' CycleLatePuberty(:,1)'];
p=ranksum(CycleDay3sAfterPubOnset,CycleDay1sAfterPubOnset);
%p=0.03


%Figure of Female E2 Data w SEM
%PreVO
figure;%plot(mean(CyclePreVO,1),'LineWidth',3,'color',[0.0 0.6 1.0]);
subplot(1,4,1);
xvalues=[1,2,3,4];
nolowerbar=[0 0 0 0];
%xvalues=[33 34 35 36]; % alternate to plot over male T
denominator=sqrt(length(CyclePreVO(:,:)));SEME2CyclePreVO=std(CyclePreVO(:,:),0,1)/denominator;
errorbar(xvalues',mean(CyclePreVO(:,:),1),nolowerbar,SEME2CyclePreVO,'color',[0.0 0.6 1.0],'LineWidth',3); hold on;axis tight;ylim([ 2000 7000]);
set(gca,'fontsize',20,'box','on');

%FirstCyclePostVO
%figure;
%plot(mean(CycleFirstVO,1),'LineWidth',3,'color',[0.0 0.6 1.0]);
xvalues=[1,2,3,4];
subplot(1,4,2)
nolowerbar=[0 0 0 0];
%xvalues=[37 38 39 40]; % alternate to plot over male T
denominator=sqrt(length(CycleFirstVO(:,:)));SEME2FirstCycleVO=std(CycleFirstVO(:,:),0,1)/denominator;
errorbar(xvalues',mean(CycleFirstVO(:,:),1),nolowerbar,SEME2FirstCycleVO,'color',[0.0 0.6 1.0],'LineWidth',3); hold on;axis tight;ylim([ 2000 7000]);
set(gca,'fontsize',20,'box','on');set(gca,'YTickLabel',{})

%Midpubertycycle
%plot(mean(CycleMidPuberty,1),'LineWidth',3,'color',[0.0 0.6 1.0]);
%46 47 48 49 is way more like acycle idk what your previous midpuberty
%cycle was
subplot(1,4,3);
nolowerbar=[0 0 0 0];
%xvalues=[46 47 48 49]; % alternate to plot over male T
xvalues=[1 2 3 4];
denominator=sqrt(length(CycleMidPubertyAlternate(:,:)));SEME2CycleMidPuberty=nanstd(CycleMidPubertyAlternate(:,:),0,1)/denominator;
errorbar(xvalues',nanmean(CycleMidPubertyAlternate(:,:),1),nolowerbar,SEME2CycleMidPuberty,'color',[0.0 0.6 1.0],'LineWidth',3); hold on;axis tight;ylim([ 2000 7000]);
set(gca,'fontsize',20,'box','on');set(gca,'YTickLabel',{})

%Late puberty cycle
%plot(mean(CycleLatePuberty,1),'LineWidth',3,'color',[0.0 0.6 1.0]);
subplot(1,4,4);
nolowerbar=[0 0 0 0];
%xvalues=[59 60 61 62]; % alternate to plot over male T
xvalues=[1 2 3 4];
denominator=sqrt(length(CycleLatePuberty(:,:)));SEME2CycleLatePuberty=nanstd(CycleLatePuberty(:,:),0,1)/denominator;
errorbar(xvalues',nanmean(CycleLatePuberty(:,:),1),nolowerbar,SEME2CycleLatePuberty,'color',[0.0 0.6 1.0],'LineWidth',3); hold on;axis tight;ylim([ 2000 7000]);
set(gca,'fontsize',20,'box','on');set(gca,'YTickLabel',{})

%Figure 1E Defining Testosterone Day of Life Average an SEM
%Average Male Profile by Day of Life Testosterone. Males except 10
Tp2425=[2104.36266	546.7752542	399.6660211	1302.559137	729.4303645	506.7067923	1070.332991	611.6835317];
Tp2627=[603.5958041	575.8612339	431.6726087	857.381225	598.3332921	353.372072	273.7062484	352.2527545];
Tp2930=[900.3377304	269.754585	279.3692425	2161.251361	425.566393	333.9267079	346.7264719	679.1780098];
Tp3233=[946.2482679	244.114238	306.4155625	1447.665026	513.0117995	201.8085736	261.3247447	367.1813021];
Tp3536=[449.9816763	313.9575642	180.1121037	857.381225	709.4938414	399.6660211	623.4852381	744.7235337];
Tp3839=[824.7310381	503.0974462	546.7752542	1377.497848	513.0117995	995.4337566	468.8192316	964.8588842];
Tp4243=[793.7714261	600.177665	300.0131286	2422.016584	900.3377304	1678.012815	285.1894629	721.0054222];
Tp4546=[396.639641	342.3883467	504.8978211	1725.998456	647.9357914	1220.545664	393.1298272	621.1007757];
Tp4849=[1254.582555	792.0746787	404.999634	4214.653103	2243.748533	8252.75933	463.9485704	2884.293246];
Tp5152=[2000.845329	712.3707879	829.3791878	5471.202698	3390.40688	3740.038879	384.216323	1287.243297];
Tp5455=[3064.867921	4070.548118	808.7479919	7011.692319	3390.40688	5768.83641	684.5648588	1191.748798];
Tp5758=[2817.429913	2674.208007	735.7090876	7946.121594	2856.821511	1669.101032	1686.988123	4474.035912];
Tp6061=[6566.630052	1488.038362	1608.45086	3655.965254	2896.930406	1933.787458	3308.13667 NaN]; %no timepoint for male 17
Tp6263=[3937.78752	5677.087631	NaN 8423.698007	6013.966711	8717.825145	1220.545664	3375.326937];%no timepoint for male 5. 
Tp6566=[5711.124938	3900.63223 NaN 3023.536108	11505.81702	12522.22043	4159.214118	1379.];%no timepoint for male5

TValuesbyDay=[Tp2425;Tp2627;Tp2930;Tp3233;Tp3536;Tp3839;Tp4243;Tp4546;Tp4849;Tp5152;Tp5455;Tp5758;Tp6061;Tp6263;Tp6566];

figure;plot([24,27,30,33,36,39,42,45,48,51,54,57,60,62,65],[mean(Tp2425,2),mean(Tp2627,2),mean(Tp2930,2),mean(Tp3233,2),mean(Tp3536,2),mean(Tp3839,2),mean(Tp4243,2),mean(Tp4546,2),mean(Tp4849,2)...
    mean(Tp5152,2),mean(Tp5455,2),mean(Tp5758,2),mean(Tp6061,2),mean(Tp6263,2),mean(Tp6566,2)],'color',[0.5 0.0 0.0],'LineWidth',3);
xlim([25 65]);

%Males with SEM Error Bars - Success -- Small Errors too!

%SEM
figure;
xvalues=[24,27,30,33,36,39,42,45,48,51,54,57,60,62,65];nolowerbar=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
denominator=sqrt(length(TValuesbyDay(:,:)));SEMTestosterone=std(TValuesbyDay(:,:),0,2)/denominator;
errorbar(xvalues',mean(TValuesbyDay(:,:),2),nolowerbar,SEMTestosterone,'color',[0.5 0.0 0],'LineWidth',3); hold on;axis tight;ylim([ 0 8000]);
set(gca,'fontsize',15,'box','on');

%stats for rise in T over life
AUCT25to45=trapz(TValuesbyDay(1:7,:));size(AUCT25to45)
AUCT45to65=trapz(TValuesbyDay(8:15,:));size(AUCT45to65)
p=ranksum(AUCT25to45,AUC45to65); 
%p=6.66ooe4
[pAUCT,tblAUCT,statsAUCT]=kruskalwallis([AUCT25to45', AUC45to65'])
%Source    SS     df      MS      Chi-sq   Prob>Chi-sq
%-----------------------------------------------------
%Groups   168      1   168         9.6       0.0019   
%Error     59.5   12     4.9583                       
%Total    227.5   13                                  

%Female E2 Over Life by Day

E2p24=[2554.253425 1906.982696	1259.533228	972.36837	850.3057331	2188.013065	3668.106965	628.238];
E2p29=[3876.084242 3008.455834	1310.900611	2090.037396	1153.338599	5710.116289	3846.092366 NaN];
E2p30=[NaN NaN NaN 1012.72079 NaN 3625.335445 4035.797259 NaN];
E2p33=[7391.462981 4691.130712 2127.050395 1012.72079 2171.18442 4454.391849 NaN NaN];
E2p34=[3788.075424 3172.745848 6302.812812 1048.083952 1887.265548 NaN 3800.533606 NaN]
E2p35=[8197.59987 4521.68797 3004.639916 915.7903447 4845.788199 4398.989257 9921.047812 2709.249];
E2p36=[NaN NaN 1678.847816 1131.934989 1939.846803 6203.796158 7161.351036 NaN];
E2p37=[4633.706742 2504.171089 2805.522688 2917.052598 4384.991458 3421.17423 5267.515463 2874.137];
E2p38=[5187.25474 4413.312216 4203.6504 570.3255263 4784.709585 4807.164688 9448.50346 2835.847];
E2p39=[6978.58898 2885.231857 3768.970749 1280.208077 3003.043216 3160.345185 6659.652692 2203.42];
E2p40=[4206.903535 2826.180639 1678.847816 2036.122481 993.4375096 5868.651632 5130.190026 3082.26];
E2p41=[2915.386225 4869.305675 1933.76849 1950.339843 2516.090731 5632.989393 4568.023262 3247.77];
E2p46=[4691.130712 1808.175132 3095.796347 3728.881652 1904.576023 7057.072611 1929.361609 NaN];
E2p47=[6415.907408 5121.458222 9233.261719 1885.175167 2109.992423 6291.556352 4510.729903 NaN];
E2p48=[8848.030667 2915.386225 3689.363215 4497.232022 2300.967003 4869.550519 5788.659474 NaN];
E2p49=[6596.394685 NaN 1967.102494 4497.232022 1541.656014 5338.021283 7057.072611 NaN];
E2p56=[9570.519022 3539.77957 NaN 3127.006525 2647.472557 6854.518974 7952.181114 NaN];
E2p57=[6783.841086 4521.68797 3223.210775 NaN 3205.286455 6117.662615 3939.420753 NaN];
E2p58=[4993.222877 8075.358367 2526.9117 3768.970749 3668.661871 5557.246983 8199.4075 3714.498];
E2p59=[5681.577089 4749.524579 1869.342162 2832.860684 3350.465329 7952.181114 3846.092366 3935.244889];
E2p60=[NaN NaN 3935 NaN 1429.716352 4685.557819 4454.391849 3521.902];
E2p61=[3349.450803 5462.222933 3158.64079 2108.434808 3350.465329 6117.662615 3583.227143 NaN];
E2p62=[6689.227063 5913.057365 2284.233009 2778.537877 1328.496039 9150.04943 3583.227143 3858.248];
E2p63=[10042.84604 7391.462981 3256.161468 1261.45796 1771.853577 7376.161285 5063.316991 4508.509];


E2ValuesbyDay=[E2p24; E2p29; E2p30; E2p33; E2p34; E2p35; E2p36; E2p37; E2p38; E2p39; E2p40; E2p41; E2p46; E2p47; E2p48; E2p49;E2p56; E2p57; E2p58; E2p59; E2p60; E2p61; E2p62; E2p63];

figure;plot([24,29,30,33:41,46:49,56:63],[nanmean(E2p24,2),nanmean(E2p29,2),nanmean(E2p30,2),nanmean(E2p33,2),nanmean(E2p34,2),nanmean(E2p35,2),nanmean(E2p36,2),nanmean(E2p37,2)...
    nanmean(E2p38,2),nanmean(E2p39,2),nanmean(E2p40,2),nanmean(E2p41,2),nanmean(E2p46,2),nanmean(E2p47,2),...
    nanmean(E2p48,2), nanmean(E2p49,2),nanmean(E2p57,2),nanmean(E2p58,2),nanmean(E2p59,2),nanmean(E2p60,2),nanmean(E2p61,2),nanmean(E2p61,2),nanmean(E2p62,2),nanmean(E2p63,2)],'color',[0.0 0.6 1.0],'LineWidth',3);
xlim([25 65]);
%Males with SEM Error Bars - Success -- Small Errors too!

%SEM
figure;
xvalues=[24,29,30,33:41,46:49,56:63];nolowerbar=zeros(1,length(xvalues));
denominator=sqrt(length(E2ValuesbyDay(:,:)));SEMEstradiol=nanstd(E2ValuesbyDay(:,:),0,2)/denominator;
errorbar(xvalues',nanmean(E2ValuesbyDay(:,:),2),nolowerbar,SEMEstradiol,'color',[0.0 0.6 1.0],'LineWidth',3); 
hold on;axis tight;ylim([ 1500 7000]);
set(gca,'fontsize',15,'box','on');

%stats for a rise in E2 by day of life
E2ValuesbyDay=[E2p24; E2p29; E2p30; E2p33; E2p34; E2p35; E2p36; E2p37; E2p38; E2p39; E2p40; E2p41; E2p46; E2p47; E2p48; E2p49;E2p56; E2p57; E2p58; E2p59; E2p60; E2p61; E2p62; E2p63];
%E2ValuesbyDayforTrap=E2ValuesbyDay;

AUCE225to35=trapz(E2ValuesbyDayforTrap(1:7,1:7));size(AUCE225to35)
AUCE235to45=trapz(E2ValuesbyDayforTrap(8:24,1:7));size(AUCE225to35)

p=ranksum(AUCE225to35,AUCE235to45); 

%p=6.66ooe4

[pAUCE2,tblAUCE2,statsAUCE2]=kruskalwallis([AUCE225to35', AUCE235to45'])
%Source     SS     df     MS      Chi-sq   Prob>Chi-sq
%-----------------------------------------------------
%Columns   171.5    1   171.5      9.8       0.0017   
%Error      56     12     4.667                       
%Total     227.5   13                                 


%% Figure 1 VO, fE2, Preputial Separation and T

for i=1:9
    E2risedays(i)=pubertycohortfs2copy3{30,FSFemales(i)};
    VOMinusE2Rise(i)=pubertycohortfs2copy3{29,FSFemales(i)}-pubertycohortfs2copy3{30,FSFemales(i)};
    disp(i)
end

for i=[1 2 5 7 9 13 14 17]
    Trisedays(i)=pubertycohortfs2copy3{30,i};
    PrepSepMinusTRise(i)=pubertycohortfs2copy3{29,i}-pubertycohortfs2copy3{30,i};
    disp(PrepSepMinusTRise(i))
end

figure;plot(VOMinusE2Rise,'color',[0.0 0.6 1.0]);
figure;plot(PrepSepMinusTRise,'color',[0.5 0.0 0.0]);

%make distribution variable for plotting from -6 to 5
HistVOMinusE2Rise=[1 1 0 1 2 0 3 1 0 0 0 0];
%distribution 5 to 15
HistPrepSepMinusTRise=[0 0 0 3 0 1 2 0 1 0 1];

figure;
subplot(1,2,1);
bar(HistVOMinusE2Rise,'FaceColor',[0.0 0.6 1.0],'EdgeAlpha',0.05); alpha(0.5);hold on;
set(gca,'XTickLabel', [-6 -5 -4 -3 -2 -1 0 1 2 3 4 5 ],'fontsize',10)
set(gca,'XTick', [ 1 2 3 4 5 6 7 8 9 10 11 12],'fontsize',10);
set(gca,'FontSize',15);
ylim([ 0 4]); 

subplot(1,2,2)
bar(HistPrepSepMinusTRise,'FaceColor',[0.5 0.0 0.0],'EdgeAlpha',0.05); alpha(0.5);hold on;
set(gca,'XTickLabel', [5 6 7 8 9 10 11 12 13 14 15 ],'fontsize',10)
set(gca,'XTick', [ 1 2 3 4 5 6 7 8 9 10 11],'fontsize',10);
set(gca,'FontSize',15);
ylim([ 0 4]); 
 


%% Figure 2 CR UR Overlay of Trend Across Puberty Aligned by Day of Life

%% CR UR Overlay

figure;
subplot(3,1,1);
plot(mean(movmeanforCRtrendfemale,2),'color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(movmeanforCRtrendfemale,2));a=fill([x fliplr(x)],[(mean(movmeanforCRtrendfemale,2)+mean(std(movmeanforCRtrendfemale,0,2),2)/sqrt(8))' flipud(mean(movmeanforCRtrendfemale,2)-mean(std(movmeanforCRtrendfemale,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; 
 set(gca,'XTickLabel', [ 26  30  34  38  42  46 50 54  58  62  66  70  74  78  82  ],'fontsize',10)
set(gca,'XTick', [  1  1440*4 1440*8 1440*12 1440*16 1440*20 1440*24 1440*28 1440*32 1440*36 1440*40 1440*44 1440*48 1440*52 1440*56 1440*60 1440*64 1440*68 1440*72 1440*76  ],'fontsize',10);
set(gca,'FontSize',15);ylim([ 0.0 1.9]);

plot(mean(movmeanforURtrendfemale,2),':','color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(movmeanforURtrendfemale,2));a=fill([x fliplr(x)],[(mean(movmeanforURtrendfemale,2)+mean(std(movmeanforURtrendfemale,0,2),2)/sqrt(8))' flipud(mean(movmeanforURtrendfemale,2)-mean(std(movmeanforURtrendfemale,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; 
 set(gca,'XTickLabel', [ 26  30  34  38  42  46 50 54  58  62  66  70  74  78  82  ],'fontsize',10)
set(gca,'XTick', [  1  1440*4 1440*8 1440*12 1440*16 1440*20 1440*24 1440*28 1440*32 1440*36 1440*40 1440*44 1440*48 1440*52 1440*56 1440*60 1440*64 1440*68 1440*72 1440*76  ],'fontsize',10);
set(gca,'FontSize',15);ylim([ 0.0 1.9]);

subplot(3,1,2);
plot(mean(movmeanforCRtrendmale,2),'color',[0.5 0.0 0.1],'LineWidth',3);hold on; 
x=1:length(mean(movmeanforCRtrendmale,2));a=fill([x fliplr(x)],[(mean(movmeanforCRtrendmale,2)+mean(std(movmeanforCRtrendmale,0,2),2)/sqrt(8))' flipud(mean(movmeanforCRtrendmale,2)-mean(std(movmeanforCRtrendmale,0,2),2)/sqrt(8))'],[0.5 0.0 0.1]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; 
 set(gca,'XTickLabel', [ 26  30  34  38  42  46 50 54  58  62  66  70  74  78  82  ],'fontsize',10)
set(gca,'XTick', [  1  1440*4 1440*8 1440*12 1440*16 1440*20 1440*24 1440*28 1440*32 1440*36 1440*40 1440*44 1440*48 1440*52 1440*56 1440*60 1440*64 1440*68 1440*72 1440*76  ],'fontsize',10);
set(gca,'FontSize',15);ylim([ 0.0 1.9]);

plot(mean(movmeanforURtrendmale,2),':','color',[0.5 0.0 0.0],'LineWidth',3);hold on; 
x=1:length(mean(movmeanforURtrendmale,2));a=fill([x fliplr(x)],[(mean(movmeanforURtrendmale,2)+mean(std(movmeanforURtrendmale,0,2),2)/sqrt(8))' flipud(mean(movmeanforURtrendmale,2)-mean(std(movmeanforURtrendmale,0,2),2)/sqrt(8))'],[0.5 0.0 0.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; 
 set(gca,'XTickLabel', [ 26  30  34  38  42  46 50 54  58  62  66  70  74  78  82  ],'fontsize',10)
set(gca,'XTick', [  1  1440*4 1440*8 1440*12 1440*16 1440*20 1440*24 1440*28 1440*32 1440*36 1440*40 1440*44 1440*48 1440*52 1440*56 1440*60 1440*64 1440*68 1440*72 1440*76  ],'fontsize',10);
set(gca,'FontSize',15);ylim([ 0.0 1.9]);


subplot(3,1,3);
plot(mean(movmeanforCRtrendfemale,2),'color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(movmeanforCRtrendfemale,2));a=fill([x fliplr(x)],[(mean(movmeanforCRtrendfemale,2)+mean(std(movmeanforCRtrendfemale,0,2),2)/sqrt(8))' flipud(mean(movmeanforCRtrendfemale,2)-mean(std(movmeanforCRtrendfemale,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; 
plot(mean(movmeanforCRtrendmale,2),'color',[0.5 0.0 0.1],'LineWidth',3);hold on; 
x=1:length(mean(movmeanforCRtrendmale,2));a=fill([x fliplr(x)],[(mean(movmeanforCRtrendmale,2)+mean(std(movmeanforCRtrendmale,0,2),2)/sqrt(8))' flipud(mean(movmeanforCRtrendmale,2)-mean(std(movmeanforCRtrendmale,0,2),2)/sqrt(8))'],[0.5 0.0 0.1]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; 
 set(gca,'XTickLabel', [ 26  30  34  38  42  46 50 54  58  62  66  70  74  78  82  ],'fontsize',10)
set(gca,'XTick', [  1  1440*4 1440*8 1440*12 1440*16 1440*20 1440*24 1440*28 1440*32 1440*36 1440*40 1440*44 1440*48 1440*52 1440*56 1440*60 1440*64 1440*68 1440*72 1440*76  ],'fontsize',10);
set(gca,'FontSize',15);ylim([ 0.0 1.9]);

plot(mean(movmeanforURtrendfemale,2),':','color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(movmeanforURtrendfemale,2));a=fill([x fliplr(x)],[(mean(movmeanforURtrendfemale,2)+mean(std(movmeanforURtrendfemale,0,2),2)/sqrt(8))' flipud(mean(movmeanforURtrendfemale,2)-mean(std(movmeanforURtrendfemale,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; 
 set(gca,'XTickLabel', [ 26  30  34  38  42  46 50 54  58  62  66  70  74  78  82  ],'fontsize',10)
set(gca,'XTick', [  1  1440*4 1440*8 1440*12 1440*16 1440*20 1440*24 1440*28 1440*32 1440*36 1440*40 1440*44 1440*48 1440*52 1440*56 1440*60 1440*64 1440*68 1440*72 1440*76  ],'fontsize',10);
set(gca,'FontSize',15);ylim([ 0.0 1.9]);

plot(mean(movmeanforURtrendmale,2),':','color',[0.5 0.0 0.0],'LineWidth',3);hold on; 
x=1:length(mean(movmeanforURtrendmale,2));a=fill([x fliplr(x)],[(mean(movmeanforURtrendmale,2)+mean(std(movmeanforURtrendmale,0,2),2)/sqrt(8))' flipud(mean(movmeanforURtrendmale,2)-mean(std(movmeanforURtrendmale,0,2),2)/sqrt(8))'],[0.5 0.0 0.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; 
 set(gca,'XTickLabel', [ 26  30  34  38  42  46 50 54  58  62  66  70  74  78  82  ],'fontsize',10)
set(gca,'XTick', [  1  1440*4 1440*8 1440*12 1440*16 1440*20 1440*24 1440*28 1440*32 1440*36 1440*40 1440*44 1440*48 1440*52 1440*56 1440*60 1440*64 1440*68 1440*72 1440*76  ],'fontsize',10);
set(gca,'FontSize',15);ylim([ 0.0 1.9]);

%% Figure 3 Top May Change Plotting UR Power Alone for Sex Differences
%male
figure;
plot(mean(movmeanforURtrendmale,2),'color',[0.5 0.0 0.0],'LineWidth',3);hold on; 
x=1:length(mean(movmeanforURtrendmale,2));a=fill([x fliplr(x)],[(mean(movmeanforURtrendmale,2)+mean(std(movmeanforURtrendmale,0,2),2)/sqrt(8))' flipud(mean(movmeanforURtrendmale,2)-mean(std(movmeanforURtrendmale,0,2),2)/sqrt(8))'],[0.5 0.0 0.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; 
 set(gca,'XTickLabel', [ 26  30  34  38  42  46 50 54  58  62  66  70  74  78  82  ],'fontsize',10)
set(gca,'XTick', [  1  1440*4 1440*8 1440*12 1440*16 1440*20 1440*24 1440*28 1440*32 1440*36 1440*40 1440*44 1440*48 1440*52 1440*56 1440*60 1440*64 1440*68 1440*72 1440*76  ],'fontsize',10);
set(gca,'FontSize',12);ylim([ 0.1 0.4]);

%female
plot(mean(movmeanforURtrendfemale,2),'color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(movmeanforURtrendfemale,2));a=fill([x fliplr(x)],[(mean(movmeanforURtrendfemale,2)+mean(std(movmeanforURtrendfemale,0,2),2)/sqrt(8))' flipud(mean(movmeanforURtrendfemale,2)-mean(std(movmeanforURtrendfemale,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; 
 set(gca,'XTickLabel', [ 26  30  34  38  42  46 50 54  58  62  66  70  74  78  82  ],'fontsize',10)
set(gca,'XTick', [  1  1440*4 1440*8 1440*12 1440*16 1440*20 1440*24 1440*28 1440*32 1440*36 1440*40 1440*44 1440*48 1440*52 1440*56 1440*60 1440*64 1440*68 1440*72 1440*76  ],'fontsize',10);
set(gca,'FontSize',12);ylim([ 0.1 0.4]);

%% Figure 2 Mann Kendall Stats 
%% Intact Females
clear movmeanforCRtrendfemale forcrMKtest FSFemales
clear mCRearlytomidfemale
clear mCRmidtolatefemale
clear mCRearlyadultfemale
%omitsickone
FSFemales=[3 4 6 8 11 15 16 18];
figure;
 for i=1:8
     subplot(2,4,i);
     hold on;
 movmeanforCRtrendfemale(:,i)=movmean(pubertycohortfs2copy3{17,FSFemales(i)}(1440*5:78714),1440); %removing the 1440 moving mean to see how the overall is affected
 plot(zscore(movmeanforCRtrendfemale(:,i)),'color',[0.0 0.6 1.0]);
  axis tight; ylim([-3 3]); %ylim([-0.6 0.8]); 
 title(FSFemales(i));
 %set(gca,'XTickLabel', [21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 ],'fontsize',10)
%set(gca,'XTick', [  1 1440*2 1440*4 1440*6 1440*8 1440*10 1440*12 1440*14 1440*16 1440*18 1440*20 1440*22 1440*24 1440*26 1440*28 1440*30 1440*32 1440*34 1440*36 1440*38 1440*40 1440*42 1440*44 1440*46 1440*48 1440*50 1440*52 1440*54 1440*56 1440*58 1440*60 1440*62 1440*64 1440*66 1440*68 1440*70 1440*72 ],'fontsize',10);
 set(gca,'XTickLabel', [ 26:4:84],'fontsize',10)
set(gca,'XTick', [  1440:1440*4:1440*72 ],'fontsize',10);

set(gca,'FontSize',10);
forcrMKtest=movmean(pubertycohortfs2copy3{17,FSFemales(i)}(1440*5:78714),1440*4); %removed additional 4 day moving mean. I shouldn't layer them anyways
[H,mCRpearlytomid(i)]=Mann_Kendall(forcrMKtest(1:1440:1440*16),0.05);  %mean of 2.0177e-4
[H,mCRpmidtolate(i)]=Mann_Kendall(forcrMKtest(1440*17:1440:1440*32),0.05); % mean of 0.1567
[H,mCRpearlyadult(i)]=Mann_Kendall(forcrMKtest(end-1440*15:1440:end),0.05);%mean of 0.1331
mCRearlytomidfemale(:,i)=forcrMKtest(1:1440:1440*16);
mCRmidtolatefemale(:,i)=forcrMKtest(1440*17:1440:1440*32);
mCRearlyadultfemale(:,i)=forcrMKtest(end-1440*15:1440:end);

plot(zscore(forcrMKtest),'color',[0.0 0.6 1.0],'LineWidth',3);
 end
 
mCRpearlytomid
mCRpmidtolate
mCRpearlyadult

%note p vals the same with non-zscored data
disp('mean of p vals early to mid puberty man kendall')
mean(mCRpearlytomid) %0.0092
disp('mean of p vals mid to late puberty man kendall')
mean(mCRpmidtolate) %0.4724
disp('mean of p vals early adult man kendall')
mean(mCRpearlyadult) %0.0696

clear FSFemales
FSFemales=[3 4 6 8 11 12 15 16 18];

%% Intact M %Limiting data window for comparability to other paper
clear movmeanforCRtrendmale forcrMKtest
figure;
 for i=1:8
     subplot(2,4,i);
     hold on;
 movmeanforCRtrendmale(:,i)=movmean(pubertycohortfs2copy3{17,FSMales(i)}(1440*5:78714),1440); %removing the 1440 moving mean to see how the overall is affected
 plot(zscore(movmeanforCRtrendmale(:,i)),'color',[0.5 0.0 0.0]);
  axis tight; ylim([-3 3]); %ylim([-0.6 0.8]); 
 title(FSMales(i));
 %set(gca,'XTickLabel', [21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 ],'fontsize',10)
%set(gca,'XTick', [  1 1440*2 1440*4 1440*6 1440*8 1440*10 1440*12 1440*14 1440*16 1440*18 1440*20 1440*22 1440*24 1440*26 1440*28 1440*30 1440*32 1440*34 1440*36 1440*38 1440*40 1440*42 1440*44 1440*46 1440*48 1440*50 1440*52 1440*54 1440*56 1440*58 1440*60 1440*62 1440*64 1440*66 1440*68 1440*70 1440*72 ],'fontsize',10);
 set(gca,'XTickLabel', [ 26:4:84],'fontsize',10)
set(gca,'XTick', [  1440:1440*4:1440*72 ],'fontsize',10);
set(gca,'FontSize',10);
forcrMKtest=movmean(pubertycohortfs2copy3{17,FSMales(i)}(1440*5:78714),1440*4); %removed additional 4 day moving mean. I shouldn't layer them anyways
[H,mCRpearlytomid(i)]=Mann_Kendall(forcrMKtest(1:1440:1440*16),0.05);  %mean of 2.0177e-4
[H,mCRpmidtolate(i)]=Mann_Kendall(forcrMKtest(1440*17:1440:1440*32),0.05); % mean of 0.1567
[H,mCRpearlyadult(i)]=Mann_Kendall(forcrMKtest(end-1440*15:1440:end),0.05);%mean of 0.1331
mCRearlytomidmale(:,i)=forcrMKtest(1:1440:1440*16);
mCRmidtolatemale(:,i)=forcrMKtest(1440*17:1440:1440*32);
mCRearlyadultmale(:,i)=forcrMKtest(end-1440*15:1440:end);

plot(zscore(forcrMKtest),'color',[0.5 0.0 0.0],'LineWidth',3);
 end
 
mCRpearlytomid
mCRpmidtolate
mCRpearlyadult

%note p vals the same with non-zscored data
disp('mean of p vals early to mid puberty man kendall')
mean(mCRpearlytomid) %0.0012
disp('mean of p vals mid to late puberty man kendall')
mean(mCRpmidtolate) %0.2003
disp('mean of p vals early adult man kendall')
mean(mCRpearlyadult) %0.3914

%% Figure 2 Violin Plots CR Level by Phase of Life
%% Field Station: Is there a difference in CR level by phase of life between sexes?

kw1=reshape(mCRearlytomidfemale,[16*8,1]);
kw2=reshape(mCRearlytomidmale,[16*8,1]);                           

figure;
subplot(3,1,1);
[h,L,MX,MED]=violin({kw1,kw2},'facecolor',[0.0 0.6 1.0;0.5 0.0 0.0],'edgecolor','k');
%title('early to mid');
ylim([-0.2 2.2]);
b = gca; legend(b,'off');set(gca,'xtick',[]);

clear group
group(1:16*9)=1 ; group(16*9+1:16*9+16*8)=2;
[pearlyCR,tblearlyCR,statsearlyCR]=kruskalwallis([kw1', kw2'],group)

%Source       SS       df       MS      Chi-sq   Prob>Chi-sq
%-----------------------------------------------------------
%Groups     98151.99     1   98151.99   15.86    6.81451e-05
%Error    1578796.01   270    5847.39                       
%Total    1676948      271         

[pearlyCR,tblearlyCR,statsearlyCR]=friedman([kw1, kw2])
%Source    SS   df      MS      Chi-sq   Prob>Chi-sq
%---------------------------------------------------
%Columns    4     1   4           8        0.0047   
%Error     60   127   0.47244                       
%Total     64   255                                 


clear kw1 kw2
kw1=reshape(mCRmidtolatefemale,[16*8,1]);
kw2=reshape(mCRmidtolatemale,[16*8,1]);
                               

subplot(3,1,2);
[h,L,MX,MED]=violin({kw1,kw2},'facecolor',[0.0 0.6 1.0;0.5 0.0 0.1],'edgecolor','k');
%title('early to mid');
ylim([-0.2 2.2]);
b = gca; legend(b,'off');set(gca,'xtick',[]);

clear group
group(1:16*9)=1 ; group(16*9+1:16*9+16*8)=2;
[pmidCR,tblmidCR,statsmidCR]=kruskalwallis([kw1', kw2'],group)

%Source      SS       df       MS      Chi-sq   Prob>Chi-sq
%----------------------------------------------------------
%Groups    130520.4     1   130520.4   21.09    4.37638e-06
%Error    1546427.6   270     5727.5                       
%Total    1676948     271       

[pmidCR,tblmidCR,statsmidCR]=friedman([kw1, kw2])
%Source      SS      df      MS      Chi-sq   Prob>Chi-sq
%--------------------------------------------------------
%Columns    1.8906     1   1.89063    3.78      0.0518   
%Error     62.1094   127   0.48905                       
%Total     64        255                                 

clear kw1 kw2
kw1=reshape(mCRearlyadultfemale,[16*8,1]);
kw2=reshape(mCRearlyadultmale,[16*8,1]);

subplot(3,1,3);
[h,L,MX,MED]=violin({kw1,kw2},'facecolor',[0.0 0.6 1.0;0.5 0.0 0.1],'edgecolor','k');
%title('early to mid');
ylim([-0.2 2.2]);
b = gca; legend(b,'off'); set(gca,'xtick',[]);

clear group
group(1:16*9)=1 ; group(16*9+1:16*9+16*8)=2;
[padultCR,tbladultCR,statsadultCR]=kruskalwallis([kw1',kw2'],group);

%Source      SS       df       MS      Chi-sq   Prob>Chi-sq
%----------------------------------------------------------
%Groups    197678.1     1   197678.1   31.95    1.58568e-08
%Error    1479269.9   270     5478.8                       
%Total    1676948     271      

[padultCR,tbladultCR,statsadultCR]=friedman([kw1, kw2])

%Source      SS      df      MS      Chi-sq   Prob>Chi-sq
%--------------------------------------------------------
%Columns    8.2656     1   8.26563   16.53    4.78548e-05
%Error     55.7344   127   0.43885                       
%Total     64        255                                 

%% Figure 2 CR power correlation to E2 and T

%prepubertal female
figure;
clear xm ym
%subplot(2,1,1)
for i=1:8%oxE2;%oxsham;%newmbc;%newnewnewm
    for j=1:length(pubertycohortfs2copy3{27,FSFemales(i)})-19
circadianstartpoint=1440*(pubertycohortfs2copy3{27,FSFemales(i)}(j,1)-21);
circadianmediantoplot=median(pubertycohortfs2copy3{16,FSFemales(i)}(circadianstartpoint:circadianstartpoint+1439))
circadianstandarddeviation=std(pubertycohortfs2copy3{16,FSFemales(i)}(circadianstartpoint:circadianstartpoint+1439))

ColormapInterval=8;%20;%length(allData{i});
clear AzureM 
AzureMRed=[0.6843:-(0.6/(ColormapInterval-1)):0.0843];
AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);

t=scatter(pubertycohortfs2copy3{27,FSFemales(i)}(j,2),circadianmediantoplot,50,[0 0.6 1],'filled'); hold on;
t.MarkerFaceAlpha=0.4;t.MarkerEdgeAlpha=0.4;
setMarkerColor(t,AzureM(i,:),1);

ylim([0 0.8]); xlim([0 10000]); %other paper ylim was 1.6
%t=scatter(pubertycohortfs2copy3{17,i}(j,2),circadianmediantoplot+circadianstandarddeviation,50,[0 0.6 1],'filled'); hold on;
%t.MarkerFaceAlpha=0.4;
%t.MarkerEdgeAlpha=0.4;

%t=scatter(pubertycohortfs2copy3{17,i}(j,2),circadianmediantoplot-circadianstandarddeviation,50,[0 0.6 1],'filled'); hold on;
%t.MarkerFaceAlpha=0.4;
%t.MarkerEdgeAlpha=0.4;

xmprepubfemale{i,j}=pubertycohortfs2copy3{27,FSFemales(i)}(j,2);
ymprepubfemale{i,j}=circadianmediantoplot;

disp(j)
    end
    disp(i)
    set(gca,'FontSize',15);
end
clear xmforfitlm ymforfitlm
xmprepubertyfemaleforfitlm=cell2mat(reshape(xmprepubfemale,[8*6,1]));ymprepubertyfemaleforfitlm=cell2mat(reshape(ymprepubfemale,[8*6,1]));
xmdl=fitlm(xmprepubertyfemaleforfitlm,ymprepubertyfemaleforfitlm)

%Linear regression model:
%    y ~ 1 + x1

%Estimated Coefficients:
%                    Estimate         SE         tStat      pValue  
%                   __________    __________    _______    _________
%
%    (Intercept)       0.22181      0.025046      8.856    2.497e-09
%    x1             5.1692e-06    8.6645e-06    0.59659      0.55594


%Number of observations: 28, Error degrees of freedom: 26
%Root Mean Squared Error: 0.0671
%R-squared: 0.0135,  Adjusted R-Squared: -0.0244
%
%F-statistic vs. constant model: 0.356, p-value = 0.556
%all of life female
figure;
clear xm ym
%subplot(2,1,1)
for i=1:8%oxE2;%oxsham;%newmbc;%newnewnewm
    for j=1:length(pubertycohortfs2copy3{27,FSFemales(i)})
circadianstartpoint=1440*(pubertycohortfs2copy3{27,FSFemales(i)}(j,1)-21);
circadianmediantoplot=median(pubertycohortfs2copy3{16,FSFemales(i)}(circadianstartpoint:circadianstartpoint+1439))
circadianstandarddeviation=std(pubertycohortfs2copy3{16,FSFemales(i)}(circadianstartpoint:circadianstartpoint+1439))

t=scatter(pubertycohortfs2copy3{27,FSFemales(i)}(j,2),circadianmediantoplot,50,[0 0.6 1],'filled'); hold on;
t.MarkerFaceAlpha=0.4;t.MarkerEdgeAlpha=0.4;

ylim([0 0.8]); xlim([0 10000]); %other paper ylim was 1.6
%t=scatter(pubertycohortfs2copy3{17,i}(j,2),circadianmediantoplot+circadianstandarddeviation,50,[0 0.6 1],'filled'); hold on;
%t.MarkerFaceAlpha=0.4;
%t.MarkerEdgeAlpha=0.4;

%t=scatter(pubertycohortfs2copy3{17,i}(j,2),circadianmediantoplot-circadianstandarddeviation,50,[0 0.6 1],'filled'); hold on;
%t.MarkerFaceAlpha=0.4;
%t.MarkerEdgeAlpha=0.4;

xmfemale{i,j}=pubertycohortfs2copy3{27,FSFemales(i)}(j,2);
ymfemale{i,j}=circadianmediantoplot;

disp(j)
    end
    disp(i)
    set(gca,'FontSize',15);
end
clear xmforfitlm ymforfitlm
xmforfitlm=cell2mat(reshape(xmfemale,[8*25,1]));ymforfitlm=cell2mat(reshape(ymfemale,[8*25,1]));
xmdl=fitlm(xmforfitlm,ymforfitlm)

%correlation is there for females for normalized but not absolute values of
%estradiol

%Linear regression model:
%    y ~ 1 + x1

%Estimated Coefficients:
%                    Estimate         SE        tStat       pValue  
%                   __________    __________    ______    __________
%
%    (Intercept)        0.2657      0.017337    15.326    1.1464e-33
%    x1             1.4744e-05    3.8482e-06    3.8313    0.00018017
%Number of observations: 169, Error degrees of freedom: 167
%Root Mean Squared Error: 0.109
%R-squared: 0.0808,  Adjusted R-Squared: 0.0753
%F-statistic vs. constant model: 14.7, p-value = 0.00018

%% Figure 2 alternate scatter with individuals different colors
%prepubertal female mixed effects model (see above for plot of individuals
%with different colors

clear zmprepubfemaleforfitlme zmprepubfemale xmprepubfemaleforfitlm  ymprepubfemaleforfitlm
for i=1:8
    for j=1:length(pubertycohortfs2copy3{27,FSFemales(i)})-19
        zmprepubfemale{i,j}=i;
    end
    disp(i)
end
xmprepubfemaleforfitlm=cell2mat(reshape(xmprepubfemale,[8*size(xmprepubfemale,2),1]));
ymprepubfemaleforfitlm=cell2mat(reshape(ymprepubfemale,[8*size(ymprepubfemale,2),1]));
zmprepubfemaleforfitlme=cell2mat(reshape(zmprepubfemale,[8*size(zmprepubfemale,2),1]));

clear tblprepubfemale
tblprepubfemale=table(xmprepubfemaleforfitlm,ymprepubfemaleforfitlm,zmprepubfemaleforfitlme,'VariableNames',{'xvalues','yvalues','groupingvalues'});

%model 2 alternate setup; correlated slope and intercept variation
%outcome~independent+(independent|group)
lme=fitlme(tblprepubfemale,'yvalues~xvalues+(xvalues|groupingvalues)')

%Linear mixed-effects model fit by ML
%Model information:
%    Number of observations              28
%    Fixed effects coefficients           2
%    Random effects coefficients         16
%    Covariance parameters                4
%Formula:
%    yvalues ~ 1 + xvalues + (1 + xvalues | groupingvalues)
%Model fit statistics:
%    AIC        BIC        LogLikelihood    Deviance
%    -61.867    -53.874    36.933           -73.867 
%Fixed effects coefficients (95% CIs):
%    Name                   Estimate      SE            tStat      DF    pValue        Lower          Upper     
%    {'(Intercept)'}           0.22174      0.024158     9.1788    26    1.2237e-09        0.17208        0.2714
%    {'xvalues'    }        5.1943e-06    8.3708e-06    0.62053    26       0.54031    -1.2012e-05    2.2401e-05
%Random effects covariance parameters (95% CIs):
%Group: groupingvalues (8 Levels)
%    Name1                  Name2                  Type            Estimate      Lower         Upper    
%    {'(Intercept)'}        {'(Intercept)'}        {'std' }         0.0027466     0.0021112    0.0035732
%    {'xvalues'    }        {'(Intercept)'}        {'corr'}                -1           NaN          NaN
%    {'xvalues'    }        {'xvalues'    }        {'std' }        1.3572e-06    6.2521e-13        2.946

%Group: Error
%    Name               Estimate    Lower       Upper  
%    {'Res Std'}        0.064667    0.049706    0.08413


%all of life female color by individual
figure;
clear xm ym
%subplot(2,1,1)
for i=1:8%oxE2;%oxsham;%newmbc;%newnewnewm
    for j=1:length(pubertycohortfs2copy3{27,FSFemales(i)})
circadianstartpoint=1440*(pubertycohortfs2copy3{27,FSFemales(i)}(j,1)-21);
circadianmediantoplot=median(pubertycohortfs2copy3{16,FSFemales(i)}(circadianstartpoint:circadianstartpoint+1439))
circadianstandarddeviation=std(pubertycohortfs2copy3{16,FSFemales(i)}(circadianstartpoint:circadianstartpoint+1439))

ColormapInterval=8;%length(allData{i});
clear AzureM 
AzureMRed=[0.6843:-(0.6/(ColormapInterval-1)):0.0843];
AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);


t=scatter(pubertycohortfs2copy3{27,FSFemales(i)}(j,2),circadianmediantoplot,100,[0 0.6 1],'filled'); hold on;
t.MarkerFaceAlpha=0.4;t.MarkerEdgeAlpha=0.8;
setMarkerColor(t,AzureM(i,:),1);

ylim([0 0.8]); xlim([0 10000]); %other paper ylim was 1.6
%t=scatter(pubertycohortfs2copy3{17,i}(j,2),circadianmediantoplot+circadianstandarddeviation,50,[0 0.6 1],'filled'); hold on;
%t.MarkerFaceAlpha=0.4;
%t.MarkerEdgeAlpha=0.4;

%t=scatter(pubertycohortfs2copy3{17,i}(j,2),circadianmediantoplot-circadianstandarddeviation,50,[0 0.6 1],'filled'); hold on;
%t.MarkerFaceAlpha=0.4;
%t.MarkerEdgeAlpha=0.4;

xmfemale{i,j}=pubertycohortfs2copy3{27,FSFemales(i)}(j,2);
ymfemale{i,j}=circadianmediantoplot;

disp(j)
    end
    disp(i)
    set(gca,'FontSize',15);
end

clear zmfemaleforfitlme zmfemale xmfemaleforfitlm  ymfemaleforfitlm
for i=1:8
    for j=1:length(pubertycohortfs2copy3{27,FSFemales(i)})
        zmfemale{i,j}=i;
    end
    disp(i)
end
% Figure 2 Version Mixed Effects Model CR power to E2 and T
clear zmfemaleforfitlme
xmfemaleforfitlm=cell2mat(reshape(xmfemale,[8*size(xmfemale,2),1]));
ymfemaleforfitlm=cell2mat(reshape(ymfemale,[8*size(ymfemale,2),1]));
zmfemaleforfitlme=cell2mat(reshape(zmfemale,[8*size(zmfemale,2),1]));

clear tblfemale
tblfemale=table(xmfemaleforfitlm,ymfemaleforfitlm,zmfemaleforfitlme,'VariableNames',{'xvalues','yvalues','groupingvalues'});

%model 2 alternate setup; correlated slope and intercept variation
%outcome~independent+(independent|group)
lme=fitlme(tblfemale,'yvalues~xvalues+(xvalues|groupingvalues)')

%Linear mixed-effects model fit by ML
%Model information:
%    Number of observations             180
%    Fixed effects coefficients           2
%    Random effects coefficients         16
%    Covariance parameters                4
%Formula:
%    yvalues ~ 1 + xvalues + (1 + xvalues | groupingvalues)

%Model fit statistics:
%    AIC        BIC       LogLikelihood    Deviance
%    -264.76    -245.6    138.38           -276.76 
%Fixed effects coefficients (95% CIs):
%    Name                   Estimate     SE            tStat     DF     pValue        Lower         Upper     
%    {'(Intercept)'}          0.26756      0.039669    6.7447    178    2.0701e-10       0.18928       0.34584
%    {'xvalues'    }        1.365e-05    6.6945e-06     2.039    178      0.042929    4.3928e-07    2.6861e-05
%Random effects covariance parameters (95% CIs):
%Group: groupingvalues (8 Levels)
%   Name1                  Name2                  Type            Estimate      Lower         Upper     
%    {'(Intercept)'}        {'(Intercept)'}        {'std' }          0.098448       0.04321        0.2243
%    {'xvalues'    }        {'(Intercept)'}        {'corr'}                -1           NaN           NaN
%    {'xvalues'    }        {'xvalues'    }        {'std' }        1.5127e-05    4.2003e-06    5.4481e-05
%Group: Error
%    Name               Estimate    Lower       Upper  
%    {'Res Std'}        0.10802     0.097384    0.11982


%% For Male CR: Testosterone Correlation
%Prepuberty
figure;
clear xm ym 

FSMales=[1 2 5 7 9 14 17];

for i=1:7%oxE2;%oxsham;%newmbc;%newnewnewm
    for j=1:length(pubertycohortfs2copy3{27,FSMales(i)})-9 % 1 through the length of the e2 or t values (number of hormonal measures)
circadianstartpoint=1440*(pubertycohortfs2copy3{27,FSMales(i)}(j,1)-21); %where to start in CRs corresponding to the first value ot E2 or T minus 21 because animals all start on p21
%This starts about p45 for a male
circadianmediantoplot=median(pubertycohortfs2copy3{16,FSMales(i)}(circadianstartpoint:circadianstartpoint+1439)); %calculates the median CR power for that day
circadianstandarddeviation=std(pubertycohortfs2copy3{16,FSMales(i)}(circadianstartpoint:circadianstartpoint+1439));%calculates the stdev of CR power for that day

ColormapInterval=7;%20;%length(allData{i});
clear AzureM 
AzureMRed=[0.9843:-(0.9/(ColormapInterval-1)):0.0843];
AzureMGreen=[0 0 0 0 0 0 0];%[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[0 0 0 0 0 0 0];%[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);


%why the eff am i plotting the median CR power from 18 days earlier??
t=scatter(pubertycohortfs2copy3{27,FSMales(i)}(j,2),circadianmediantoplot,50,[0.5 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.4;t.MarkerEdgeAlpha=0.4;ylim([0 0.8]); xlim([0 10000]);%xlim([ -3 3]);%xlim([0 5000]);
setMarkerColor(t,AzureM(i,:),1);


xmprepubmale{i,j}=pubertycohortfs2copy3{27,FSMales(i)}(j,2);
ymprepubmale{i,j}=circadianmediantoplot;

disp(j)
    end
    disp(i)
    set(gca,'FontSize',15);
end
clear xmforfitlm ymforfitlm
xmforfitlm=cell2mat(reshape(xmprepubmale,[7*6,1]));ymforfitlm=cell2mat(reshape(ymprepubmale,[7*6,1]));
xmdl=fitlm(xmforfitlm,ymforfitlm)

%%Uncorrelated prior to pubertal onset

%Linear regression model:
%    y ~ 1 + x1

%Estimated Coefficients:
%                    Estimate         SE         tStat      pValue  
%                   __________    __________    _______    _________

%    (Intercept)        0.2493      0.022861     10.905    4.316e-14
%    x1             8.8577e-06    2.6088e-05    0.33953      0.73582


%Number of observations: 46, Error degrees of freedom: 44
%Root Mean Squared Error: 0.0883
%R-squared: 0.00261,  Adjusted R-Squared: -0.0201
%F-statistic vs. constant model: 0.115, p-value = 0.736

%mixed effects model

clear zmprepubmaleforfitlme zmprepubmale xmprepubmaleforfitlm  ymprepubmaleforfitlm
for i=1:7
    for j=1:length(pubertycohortfs2copy3{27,FSMales(i)})-9
        zmprepubmale{i,j}=i;
    end
    disp(i)
end
% Figure 2 Version Mixed Effects Model CR power to E2 and T
clear zmprepubmaleforfitlme
xmprepubmaleforfitlm=cell2mat(reshape(xmprepubmale,[7*size(xmprepubmale,2),1]));
ymprepubmaleforfitlm=cell2mat(reshape(ymprepubmale,[7*size(ymprepubmale,2),1]));
zmprepubmaleforfitlme=cell2mat(reshape(zmprepubmale,[7*size(zmprepubmale,2),1]));

clear tblprepubmale
tblprepubmale=table(xmprepubmaleforfitlm,ymprepubmaleforfitlm,zmprepubmaleforfitlme,'VariableNames',{'xvalues','yvalues','groupingvalues'});

%model 2 alternate setup; correlated slope and intercept variation
%outcome~independent+(independent|group)
lme=fitlme(tblprepubmale,'yvalues~xvalues+(xvalues|groupingvalues)')

%Linear mixed-effects model fit by ML
%Model information:
 %   Number of observations              39
 %   Fixed effects coefficients           2
 %   Random effects coefficients         14
 %   Covariance parameters                4
%Formula:
%    yvalues ~ 1 + xvalues + (1 + xvalues | groupingvalues)
%Model fit statistics:
 %   AIC        BIC        LogLikelihood    Deviance
  %  -71.116    -61.135    41.558           -83.116 
%Fixed effects coefficients (95% CIs):
%    Name                   Estimate      SE            tStat      DF    pValue        Lower          Upper     
%    {'(Intercept)'}           0.24926      0.025754     9.6785    37    1.1096e-11        0.19708       0.30144
%    {'xvalues'    }        3.8087e-06    2.9819e-05    0.12772    37       0.89906    -5.6611e-05    6.4229e-05
%Random effects covariance parameters (95% CIs):
%Group: groupingvalues (7 Levels)
%    Name1                  Name2                  Type            Estimate      Lower         Upper     
%    {'(Intercept)'}        {'(Intercept)'}        {'std' }          0.022125       0.01769      0.027671
%    {'xvalues'    }        {'(Intercept)'}        {'corr'}                -1           NaN           NaN
%    {'xvalues'    }        {'xvalues'    }        {'std' }        1.4056e-05    5.6013e-07    0.00035275
%Group: Error
%    Name               Estimate    Lower       Upper  
%    {'Res Std'}        0.082275    0.065747    0.10296



%Postpubertalonset
% males need evaluation of pre and post puberty onset with non normalized
% data for both
figure;
clear xmmale ymmale
%subplot(1,2,2)
FSMales=[1 2 5 7 9 14 17];
for i=1:7%oxE2;%oxsham;%newmbc;%newnewnewm
    for j=7:length(pubertycohortfs2copy3{27,FSMales(i)}) % 1 through the length of the e2 or t values (number of hormonal measures)
circadianstartpoint=1440*(pubertycohortfs2copy3{27,FSMales(i)}(j,1)-21); %where to start in CRs corresponding to the first value ot E2 or T minus 21 because animals all start on p21
%This starts about p45 for a male
circadianmediantoplot=median(pubertycohortfs2copy3{16,FSMales(i)}(circadianstartpoint:circadianstartpoint+1439)); %calculates the median CR power for that day
circadianstandarddeviation=std(pubertycohortfs2copy3{16,FSMales(i)}(circadianstartpoint:circadianstartpoint+1439));%calculates the stdev of CR power for that day

ColormapInterval=7
clear AzureM 
AzureMRed=[0.9843:-(0.9/(ColormapInterval-1)):0.0843];
AzureMGreen=[0 0 0 0 0 0 0];%[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[0 0 0 0 0 0 0];%[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);

%why the eff am i plotting the median CR power from 18 days earlier??
t=scatter(pubertycohortfs2copy3{27,FSMales(i)}(j,2),circadianmediantoplot,100,[0.5 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.4;t.MarkerEdgeAlpha=0.4;ylim([0 0.8]); xlim([0 10000]);%xlim([ -3 3]);%xlim([0 5000]);
setMarkerColor(t,AzureM(i,:),1);

xmmale{i,j-6}=pubertycohortfs2copy3{27,FSMales(i)}(j,2);
ymmale{i,j-6}=circadianmediantoplot;

%xmmale2{i,j}=pubertycohortfs2copy3{27,FSMales(i)}(j,2);
%ymmale2{i,j}=circadianmediantoplot;

disp(j)
    end
    disp(i)
    set(gca,'FontSize',15);
end
clear xmforfitlm ymforfitlm
xmforfitlm=cell2mat(reshape(xmmale,[7*9,1]));ymforfitlm=cell2mat(reshape(ymmale,[7*9,1]));

xmdl=fitlm(xmforfitlm,ymforfitlm)

%Linear regression model:
%    y ~ 1 + x1

%Estimated Coefficients:
%                    Estimate          SE         tStat       pValue  
%                   ___________    __________    _______    __________
%
%    (Intercept)        0.29201      0.015492     18.849    2.0785e-26
%    x1             -1.0508e-05    4.3793e-06    -2.3996      0.019647


%Number of observations: 60, Error degrees of freedom: 58
%Root Mean Squared Error: 0.08
%R-squared: 0.0903,  Adjusted R-Squared: 0.0746
%F-statistic vs. constant model: 5.76, p-value = 0.0196


FSMales=[1 2 5 7 9 10 14 17];

%% Males Mixed Effects Model CR power by fT

clear zmmaleforfitlme zmmale xmmaleforfitlm  ymbmaleforfitlm
for i=1:7
    for j=7:length(pubertycohortfs2copy3{27,FSMales(i)})
        zmmale{i,j}=i;
    end
    disp(i)
end
% Figure 2 Version Mixed Effects Model CR power to E2 and T
clear zmprepubmaleforfitlme
xmmaleforfitlm=cell2mat(reshape(xmmale,[7*size(xmmale,2),1]));
ymmaleforfitlm=cell2mat(reshape(ymmale,[7*size(ymmale,2),1]));
zmmaleforfitlme=cell2mat(reshape(zmmale,[7*size(zmmale,2),1]));

clear tblmale
tblmale=table(xmmaleforfitlm,ymmaleforfitlm,zmmaleforfitlme,'VariableNames',{'xvalues','yvalues','groupingvalues'});

%model 2 alternate setup; correlated slope and intercept variation
%outcome~independent+(independent|group)
lme=fitlme(tblmale,'yvalues~xvalues+(xvalues|groupingvalues)')


%Linear mixed-effects model fit by ML

%Model information:
%    Number of observations              60
%    Fixed effects coefficients           2
%    Random effects coefficients         14
%    Covariance parameters                4

%Formula:
%    yvalues ~ 1 + xvalues + (1 + xvalues | groupingvalues)

%Model fit statistics:
%    AIC        BIC        LogLikelihood    Deviance
%    -132.08    -119.52    72.041           -144.08 

%Fixed effects coefficients (95% CIs):
 %   Name                   Estimate       SE            tStat      DF    pValue        Lower          Upper     
 %   {'(Intercept)'}            0.28558      0.018777     15.209    58    6.6727e-22          0.248       0.32317
 %   {'xvalues'    }        -7.9905e-06    4.4604e-06    -1.7914    58      0.078443    -1.6919e-05    9.3799e-07

%Random effects covariance parameters (95% CIs):
%Group: groupingvalues (7 Levels)
%    Name1                  Name2                  Type            Estimate      Lower         Upper     
%    {'(Intercept)'}        {'(Intercept)'}        {'std' }          0.033351      0.010955       0.10153
%    {'xvalues'    }        {'(Intercept)'}        {'corr'}                 1           NaN           NaN
%    {'xvalues'    }        {'xvalues'    }        {'std' }        2.5899e-06    1.1346e-07    5.9114e-05

%Group: Error
%    Name               Estimate    Lower       Upper   
%    {'Res Std'}        0.067096    0.055554    0.081037

%% Figure 2 alternate male scatter individualized color

ColormapInterval=20;%length(allData{i});
clear AzureM 
AzureMRed=[0.6843:-(0.6/(ColormapInterval-1)):0.0843];
AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);

figure;
clear xm ym AzureMRed AzureMGreen AzureMBlue
%subplot(1,2,2)
FSMales=[1 2 5 7 9 14 17];
for i=1:7%oxE2;%oxsham;%newmbc;%newnewnewm
    for j=7:13;%length(pubertycohortfs2copy3{27,FSMales(i)}) % 1 through the length of the e2 or t values (number of hormonal measures)
circadianstartpoint=1440*(pubertycohortfs2copy3{27,FSMales(i)}(j,1)-21); %where to start in CRs corresponding to the first value ot E2 or T minus 21 because animals all start on p21
%This starts about p45 for a male
circadianmediantoplot=median(pubertycohortfs2copy3{16,FSMales(i)}(circadianstartpoint:circadianstartpoint+1439)); %calculates the median CR power for that day
circadianstandarddeviation=std(pubertycohortfs2copy3{16,FSMales(i)}(circadianstartpoint:circadianstartpoint+1439));%calculates the stdev of CR power for that day

ColormapInterval=7;%length(allData{i});
clear AzureM  
AzureMRed=[0.9843:-(0.9/(ColormapInterval-1)):0.0843];
AzureMGreen=[ 0 0 0 0 0 0 0];%AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[0 0 0 0 0 0 0];%[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);


%why the eff am i plotting the median CR power from 18 days earlier??
t=scatter(pubertycohortfs2copy3{27,FSMales(i)}(j,2),circadianmediantoplot,100,[0.5 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.4;t.MarkerEdgeAlpha=0.8;ylim([0 0.8]); xlim([0 10000]);%xlim([ -3 3]);%xlim([0 5000]);
setMarkerColor(t,AzureM(j-6,:),1);

xm{i,j-6}=pubertycohortfs2copy3{27,FSMales(i)}(j,2);
ym{i,j-6}=circadianmediantoplot;

disp(j)
    end
    disp(i)
    set(gca,'FontSize',15);
end

%% Figure 2 Bottom Non-Personalized Individual UR Profiles; Here Averaging 2-3 h Power
%% MUST DEFINE FS Ultradian Power and Trends; No trend in UR power over life
%Adapting Trend for Female URs
clear movmeanforURtrendfemale forurMKtest
figure;
 for i=1:8
     subplot(2,4,i);
     hold on;
     %Using mean of 2-3 h band as was done in naf paper
 movmeanforURtrendfemale(:,i)=movmean(mean([pubertycohortfs2copy3{13,FSFemales(i)}(1440*5:78714),pubertycohortfs2copy3{14,FSFemales(i)}(1440*5:78714)],2),1440); %removing the 1440 moving mean to see how the overall is affected
 plot(zscore(movmeanforURtrendfemale(:,i)),'color',[0.0 0.6 1.0],'LineWidth',3);
  axis tight; ylim([-4 4]); %ylim([-0.6 0.8]); 
 title(FSFemales(i));
%set(gca,'XTickLabel', [21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 ],'fontsize',10)
%set(gca,'XTick', [  1 1440*2 1440*4 1440*6 1440*8 1440*10 1440*12 1440*14 1440*16 1440*18 1440*20 1440*22 1440*24 1440*26 1440*28 1440*30 1440*32 1440*34 1440*36 1440*38 1440*40 1440*42 1440*44 1440*46 1440*48 1440*50 1440*52 1440*54 1440*56 1440*58 1440*60 1440*62 1440*64 1440*66 1440*68 1440*70 1440*72 ],'fontsize',10);
 set(gca,'XTickLabel', [ 26:4:84],'fontsize',10)
set(gca,'XTick', [  1440:1440*4:1440*72 ],'fontsize',10);
set(gca,'FontSize',10);
forurMKtest=movmean(mean([pubertycohortfs2copy3{13,FSFemales(i)}(1440*5:78714),pubertycohortfs2copy3{14,FSFemales(i)}(1440*5:78714)],2),1440*4); %removed additional 4 day moving mean. I shouldn't layer them anyways
[H,mURpearlytomid(i)]=Mann_Kendall(forurMKtest(1:1440:1440*16),0.05);  %mean of 2.0177e-4
[H,mURpmidtolate(i)]=Mann_Kendall(forurMKtest(1440*17:1440:1440*32),0.05); % mean of 0.1567
[H,mURpearlyadult(i)]=Mann_Kendall(forurMKtest(end-1440*15:1440:end),0.05);%mean of 0.1331
mURearlytomidfemale(:,i)=forurMKtest(1:1440:1440*16);
mURmidtolatefemale(:,i)=forurMKtest(1440*17:1440:1440*32);
mURearlyadultfemale(:,i)=forurMKtest(end-1440*15:1440:end);
%plot(zscore(forurMKtest),'color',[0.0 0.6 1.0],'LineWidth',3);
 end
 
mURpearlytomid
mURpmidtolate
mURpearlyadult

%note p vals the same with non-zscored data
disp('mean of p vals early to mid puberty man kendall')
mean(mURpearlytomid) %0.1475
disp('mean of p vals mid to late puberty man kendall')
mean(mURpmidtolate) %0.2315
disp('mean of p vals early adult man kendall')
mean(mURpearlyadult) %0.5949
%% Figure 2 Male Individual 2-3 h UR Power Trends - No male UR Power trends
%% Defining FS Male Ultradian Power and Trends
clear movmeanforURtrendmale forcrMKtest
figure;
 for i=1:8
     subplot(2,4,i);
     hold on;
 movmeanforURtrendmale(:,i)=movmean(mean([pubertycohortfs2copy3{13,FSMales(i)}(1440*5:78714),pubertycohortfs2copy3{14,FSMales(i)}(1440*5:78714)],2),1440); %removing the 1440 moving mean to see how the overall is affected
 plot(zscore(movmeanforURtrendmale(:,i)),'color',[0.5 0.0 0.0],'LineWidth',3);
  axis tight; ylim([-4 4]); %ylim([-0.6 0.8]); 
 title(FSMales(i));
 %set(gca,'XTickLabel', [21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 ],'fontsize',10)
%set(gca,'XTick', [  1 1440*2 1440*4 1440*6 1440*8 1440*10 1440*12 1440*14 1440*16 1440*18 1440*20 1440*22 1440*24 1440*26 1440*28 1440*30 1440*32 1440*34 1440*36 1440*38 1440*40 1440*42 1440*44 1440*46 1440*48 1440*50 1440*52 1440*54 1440*56 1440*58 1440*60 1440*62 1440*64 1440*66 1440*68 1440*70 1440*72 ],'fontsize',10);
 set(gca,'XTickLabel', [ 26:4:84],'fontsize',10)
set(gca,'XTick', [  1440:1440*4:1440*72 ],'fontsize',10);
set(gca,'FontSize',10);
forurMKtest=movmean(mean([pubertycohortfs2copy3{13,FSMales(i)}(1440*5:78714),pubertycohortfs2copy3{14,FSMales(i)}(1440*5:78714)],2),1440*4); %removing the 1440 moving mean to see how the overall is affected
[H,mURpearlytomid(i)]=Mann_Kendall(forurMKtest(1:1440:1440*16),0.05);  %mean of 2.0177e-4
[H,mURpmidtolate(i)]=Mann_Kendall(forurMKtest(1440*17:1440:1440*32),0.05); % mean of 0.1567
[H,mURpearlyadult(i)]=Mann_Kendall(forurMKtest(end-1440*15:1440:end),0.05);%mean of 0.1331
mURearlytomidmale(:,i)=forurMKtest(1:1440:1440*16);
mURmidtolatemale(:,i)=forurMKtest(1440*17:1440:1440*32);
mURearlyadultmale(:,i)=forurMKtest(end-1440*15:1440:end);
%plot(zscore(forurMKtest),'color',[0.5 0.0 0.0],'LineWidth',3);
 end
 
mURpearlytomid
mURpmidtolate
mURpearlyadult

%note p vals the same with non-zscored data
disp('mean of p vals early to mid puberty man kendall')
mean(mURpearlytomid) %0.2431
disp('mean of p vals mid to late puberty man kendall')
mean(mURpmidtolate) %0.3494
disp('mean of p vals early adult man kendall')
mean(mURpearlyadult) %0.2575


%% Figure 3C FFTs all of life 4 Day Modulation of 1440 Temperature Movmean Is Visible Most In Intact Animals, Less in MBC Animals, Least in other Groups

%Visualize the fourier transform of the mildly smoothed signal in all 4
%groups

%Compute the Fourier transform of the signal.
figure; 
for i=1:8
   % figure;
signaltofft=movmean(pubertycohortfs2copy3{18,FSFemales(i)}(1440*5:end),1440); %smooth just a little to reduce noise
Y = fft(signaltofft);
%Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
Fs = 1/60;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(signaltofft);             % Length of signal
t = (0:L-1)*T;        % Time vector
P2 = abs(Y/L);P1 = P2(1:L/2+1);P1(2:end-1) = 2*P1(2:end-1);f = Fs*(0:(L/2))/L;
hold on;plot(f,P1,'color',[0.0 0.6 1.0],'LineWidth',2.5) 
xlim([2.2E-06 3.6E-06]);
femaletempffttrapz(i)=trapz(f(10:16),P1(10:16));
end


for i=1:8
   % figure;
signaltofft=movmean(pubertycohortfs2copy3{18,FSMales(i)}(1440*5:end),1440); %smooth just a little to reduce noise
Y = fft(signaltofft);
%Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
Fs = 1/60;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(signaltofft);             % Length of signal
t = (0:L-1)*T;        % Time vector
P2 = abs(Y/L);P1 = P2(1:L/2+1);P1(2:end-1) = 2*P1(2:end-1);f = Fs*(0:(L/2))/L;
hold on;plot(f,P1,'color',[0.5 0.0 0.0],'LineWidth',2.5) 
xlim([2.2E-06 3.6E-06]);
maletempffttrapz(i)=trapz(f(10:16),P1(10:16));
end

%ctrl 2.5 to 3.5 days in hz is 4.6e-06 to 3.3e-06 indices 10:16 is not significant chi
%0.18 p=0.674

[pffttrapz,tblffttrapz,statsffttrapz]=kruskalwallis([femaletempffttrapz', maletempffttrapz'])
%Source    SS    df   MS    Chi-sq   Prob>Chi-sq
%-----------------------------------------------
%Columns   256    1   256   11.29      0.0008   
%Error      84   14     6                       
%Total     340   15                             

%% Figure 3D Variable Defs Ultradian Rhythms and the Ovulatory Cycle Figure
clear FemaleLineardatanearfE2rise FemaleNewURsnearfE2rise FemaleNewCRsnearfE2rise FemaleNewZURsnearfE2rise FemaleNewZCRsnearfE2rise
%previously was using newnewm
for a =1:8
startpoint=1440*(pubertycohortfs2copy3{29,FSFemales(a)}-29);%previously25
%azure help me understand how your start point mapped on to 7 days prior to
%e2 rise. it looks as though, with 25 as your setup. you were starting 25
%days prior to e2 rise, which is difficult to understand when e2 rise was
%something like p33 (p8 which would make no sense)...Ah I see it now. it is
%with reference to days into the log. so 8 days into the naf log would be
%18+8 = 26. So we start a variable number of days into the log equal to 7
%days before e2 rise
% End point is 40 days after start point (originally 45, but the fs data
% set is a little shorter. to about p64 instead of 74
endpoint=startpoint+1440*45;
startpointdaybyday=pubertycohortfs2copy3{29,FSFemales(a)}-29;%previously25
%endpointdaybyday=startpointdaybyday+45 %previously40
%NewURsnearfE2rise(:,a)=movmean(pubertycohortfs2copy3{5,newnewm(a)}(startpoint:endpoint),1440);
%NewCRsnearfE2rise(:,a)=movmean(pubertycohortfs2copy3{6,newnewm(a)}{1,1}(startpoint:endpoint),1440);
%NightlyRangenearfE2rise(:,a)=pubertycohortfs2copy3{8,newnewm(a)}(startpointdaybyday:endpointdaybyday);
%NightlySumnearfE2rise(:,a)=pubertycohortfs2copy3{7,newnewm(a)}(startpointdaybyday:endpointdaybyday);
%DailyRangenearfE2rise(:,a)=pubertycohortfs2copy3{12,newnewm(a)}(startpointdaybyday:endpointdaybyday);
%DailySumnearfE2rise(:,a)=pubertycohortfs2copy3{11,newnewm(a)}(startpointdaybyday:endpointdaybyday);
%DailyMediannearfE2rise(:,a)=pubertycohortfs2copy3{13,newnewm(a)}(startpointdaybyday:endpointdaybyday);
%NightlyMediannearfE2rise(:,a)=pubertycohortfs2copy3{9,newnewm(a)}(startpointdaybyday:endpointdaybyday);
FemaleLineardatanearfE2rise(:,a)=movmean(pubertycohortfs2copy3{19,FSFemales(a)}(startpoint:endpoint),1440);
FemaleNewURsnearfE2rise(:,a)=movmean(mean([pubertycohortfs2copy3{14,FSFemales(a)}(startpoint:endpoint) pubertycohortfs2copy3{13,FSFemales(a)}(startpoint:endpoint),pubertycohortfs2copy3{12,FSFemales(a)}(startpoint:endpoint),pubertycohortfs2copy3{15,FSFemales(a)}(startpoint:endpoint)],2),1440);
FemaleNewURsnearfE2rise1(:,a)=movmean(pubertycohortfs2copy3{12,FSFemales(a)}(startpoint:endpoint),1440);
FemaleNewURsnearfE2rise2(:,a)=movmean(pubertycohortfs2copy3{13,FSFemales(a)}(startpoint:endpoint),1440);
FemaleNewURsnearfE2rise3(:,a)=movmean(pubertycohortfs2copy3{14,FSFemales(a)}(startpoint:endpoint),1440);
FemaleNewURsnearfE2rise4(:,a)=movmean(pubertycohortfs2copy3{15,FSFemales(a)}(startpoint:endpoint),1440);
FemaleNewURsnearfE2rise5(:,a)=movmean(pubertycohortfs2copy3{16,FSFemales(a)}(startpoint:endpoint),1440);
FemaleNewCRsnearfE2rise(:,a)=movmean(pubertycohortfs2copy3{17,FSFemales(a)}(startpoint:endpoint),1440);
FemaleNewCRsnearfE2rise(:,a)=movmean(pubertycohortfs2copy3{11,FSFemales(a)}(startpoint:endpoint),1440);
FemaleNewZURsnearfE2rise(:,a)=zscore(movmean(mean([pubertycohortfs2copy3{14,FSFemales(a)}(startpoint:endpoint),pubertycohortfs2copy3{13,FSFemales(a)}(startpoint:endpoint),pubertycohortfs2copy3{12,FSFemales(a)}(startpoint:endpoint),pubertycohortfs2copy3{15,FSFemales(a)}(startpoint:endpoint)],2),1440));
FemaleNewZCRsnearfE2rise(:,a)=zscore(movmean(pubertycohortfs2copy3{11,FSFemales(a)}(startpoint:endpoint),1440));
FemaleNewCRCoherencenearfE2rise(:,a)=movmean(pubertycohortfs2copy3{26,FSFemales(a)}(startpoint:endpoint),1440);
FemaleNewUR23CoherencenearfE2rise(:,a)=movmean(pubertycohortfs2copy3{21,FSFemales(a)}(startpoint:endpoint),1440);
%NightlySumnearfE2rise(:,a)=pubertycohortfs2copy3{7,FSFemales(a)}(startpointdaybyday:endpointdaybyday);
%DailyRangenearfE2rise(:,a)=pubertycohortfs2copy3{12,FSFemales(a)}(startpointdaybyday:endpointdaybyday);
%DailySumnearfE2rise(:,a)=pubertycohortfs2copy3{11,FSFemales(a)}(startpointdaybyday:endpointdaybyday);
%DailyMediannearfE2rise(:,a)=pubertycohortfs2copy3{13,FSFemales(a)}(startpointdaybyday:endpointdaybyday);
%NightlyMediannearfE2rise(:,a)=pubertycohortfs2copy3{9,FSFemales(a)}(startpointdaybyday:endpointdaybyday);
end

%% Figure 3D Here is the one I actually used in the paper for figure 3D
%1 to 4 h URs averaged by fE2 proximity Best so far
figure;
%subplot(3,4,9:12);
hold on;
plot(mean(FemaleNewZURsnearfE2rise ,2),'color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(FemaleNewZURsnearfE2rise ,2));a=fill([x fliplr(x)],[(mean(FemaleNewZURsnearfE2rise ,2)+mean(std(FemaleNewZURsnearfE2rise ,0,2),2)/sqrt(8))' flipud(mean(FemaleNewZURsnearfE2rise ,2)-mean(std(FemaleNewZURsnearfE2rise ,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; ylim([-2 2]);
set(gca,'XTickLabels', [7  5 3  1  1  3  5  7  9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39],'fontsize',10)
set(gca,'XTick', [1:1440*2:1440*50],'fontsize',15);

%% Figure 3D Trying FFT of Female UR Power

%Compute the Fourier transform of the signal.
figure; 
for i=1:8
   % figure;
signaltofft=movmean(FemaleNewZURsnearfE2rise(1440*5:end,i),1440); %smooth just a little to reduce noise
Y = fft(signaltofft);
%Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
Fs = 1/60;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(signaltofft);             % Length of signal
t = (0:L-1)*T;        % Time vector
P2 = abs(Y/L);P1 = P2(1:L/2+1);P1(2:end-1) = 2*P1(2:end-1);f = Fs*(0:(L/2))/L;
hold on;plot(f,P1,'color',[0.0 0.6 1.0],'LineWidth',2.5) 
xlim([2.2E-06 3.6E-06]);
femaleURffttrapz(i)=trapz(f(10:16),P1(10:16));
end


%figure; 
for i=1:8
   % figure;
signaltofft=movmean(MaleNewZURsnearfE2rise(1440*5:end,i),1440); %smooth just a little to reduce noise
Y = fft(signaltofft);
%Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
Fs = 1/60;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(signaltofft);             % Length of signal
t = (0:L-1)*T;        % Time vector
P2 = abs(Y/L);P1 = P2(1:L/2+1);P1(2:end-1) = 2*P1(2:end-1);f = Fs*(0:(L/2))/L;
hold on;plot(f,P1,'color',[0.5 0.0 0.0],'LineWidth',2.5) 
xlim([2.2E-06 3.6E-06]);
maleURffttrapz(i)=trapz(f(10:16),P1(10:16));
end



%ctrl 2.5 to 3.5 days in hz is 4.6e-06 to 3.3e-06 indices 10:16 is not significant chi
%0.18 p=0.674

[pffttrapzUR,tblffttrapzUR,statsffttrapzUR]=kruskalwallis([femaleURffttrapz', maleURffttrapz'])
%Source      SS     df     MS      Chi-sq   Prob>Chi-sq
%------------------------------------------------------
%Columns   210.25    1   210.25     9.28      0.0023   
%Error     129.75   14     9.268                       
%Total     340      15                                 

%% Alternate Figure 3D Visualizations
% Brute Force Eyeball Determination of Most cyclic band per individual
%%Let's Make a Personalized UR Band Array
FemalePersonalizedURsnearfE2Rise(:,1)=FemaleNewURsnearfE2rise1(:,1);
FemalePersonalizedURsnearfE2Rise(:,2)=FemaleNewURsnearfE2rise4(:,2);
FemalePersonalizedURsnearfE2Rise(:,3)=FemaleNewURsnearfE2rise5(:,3);
FemalePersonalizedURsnearfE2Rise(:,4)=FemaleNewURsnearfE2rise5(:,4);
FemalePersonalizedURsnearfE2Rise(:,5)=FemaleNewURsnearfE2rise5(:,5);
FemalePersonalizedURsnearfE2Rise(:,6)=FemaleNewURsnearfE2rise2(:,6);
FemalePersonalizedURsnearfE2Rise(:,7)=FemaleNewURsnearfE2rise5(:,7);
FemalePersonalizedURsnearfE2Rise(:,8)=FemaleNewURsnearfE2rise3(:,8);

for i=1:8
    FemalezPersonalizedURsnearfE2Rise(:,i)=zscore(FemalePersonalizedURsnearfE2Rise(:,i));
    NewCycleMetricfs(:,i)=FemaleNewZURsnearfE2rise(:,i)-zscore(FemaleLineardatanearfE2rise(:,i));
end

figure;
for i=1:8
    
    hold on;
    plot(movmean(FemaleLineardatanearfE2rise(:,i),1440*2),'color',[0.0 0.6 1.0],'LineWidth',3);
    set(gca,'XTickLabels', [1 1 7  3   1   5    9    13    17  21  25 29  33  37  41  45  51 ],'fontsize',10)
set(gca,'XTick', [1:1440*4:1440*70],'fontsize',10);title(' ');axis tight;ylim([0.1 1.5]);
set(gca,'FontSize',10);ylim([-3 3.2]);title(FSFemales(i));
disp(i)
end

figure;
for i=1:8
    subplot(2,4,i);
    hold on;
    plot(FemaleNewZURsnearfE2rise(:,i),'color',[0.0 0.6 1.0],'LineWidth',3);
    set(gca,'XTickLabels', [11 7  3   1   5    9    13    17  21  25 29  33  37  41  45  51 ],'fontsize',10)
set(gca,'XTick', [1:1440*4:1440*70],'fontsize',10);title(' ');axis tight;ylim([0.1 1.5]);
set(gca,'FontSize',10);ylim([-3 3.2]);title(FSFemales(i));
disp(i)
end

%New Cycle Metric FS with the averaged medium URs looks pretty crazy
figure;
plot(movmean(mean(NewCycleMetricfs ,2),1440),'color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(NewCycleMetricfs ,2));a=fill([x fliplr(x)],[(mean(NewCycleMetricfs ,2)+mean(std(NewCycleMetricfs ,0,2),2)/sqrt(8))' flipud(mean(NewCycleMetricfs ,2)-mean(std(NewCycleMetricfs ,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; ylim([-2 3]);
set(gca,'XTickLabels', [7  5 3  1  1  3  5  7  9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39],'fontsize',10)
set(gca,'XTick', [1:1440*2:1440*50],'fontsize',15);ylim([-2 2.75]);

% Linear data near fe2 rise average don't look like shite
figure;
plot(movmean(mean(FemaleLineardatanearfE2rise ,2),1440),'color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(FemaleLineardatanearfE2rise ,2));a=fill([x fliplr(x)],[(mean(FemaleLineardatanearfE2rise ,2)+mean(std(FemaleLineardatanearfE2rise ,0,2),2)/sqrt(8))' flipud(mean(FemaleLineardatanearfE2rise ,2)-mean(std(FemaleLineardatanearfE2rise ,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; ylim([-0.35 0.5]);
set(gca,'XTickLabels', [7  5 3  1  1  3  5  7  9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39],'fontsize',10)
set(gca,'XTick', [1:1440*2:1440*50],'fontsize',15); xlim([0 1440*14]);


%This one is ok but prolly not worth it Individual UR cyclicity every 4 days
figure;
plot(mean(FemalezPersonalizedURsnearfE2Rise,2),'color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(FemalezPersonalizedURsnearfE2Rise,2));a=fill([x fliplr(x)],[(mean(FemalezPersonalizedURsnearfE2Rise,2)+mean(std(FemalezPersonalizedURsnearfE2Rise,0,2),2)/sqrt(8))' flipud(mean(FemalezPersonalizedURsnearfE2Rise,2)-mean(std(FemalezPersonalizedURsnearfE2Rise,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; ylim([-2 2]);
set(gca,'XTickLabels', [7  5 3  1  1  3  5  7  9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39],'fontsize',10)
set(gca,'XTick', [1:1440*2:1440*50],'fontsize',15);

%Aligning URs Coherence by Fe2 rise looks like crap
figure;
plot(mean(FemaleNewUR23CoherencenearfE2rise,2),'color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(FemaleNewUR23CoherencenearfE2rise,2));a=fill([x fliplr(x)],[(mean(FemaleNewUR23CoherencenearfE2rise,2)+mean(std(FemaleNewUR23CoherencenearfE2rise,0,2),2)/sqrt(8))' flipud(mean(FemaleNewUR23CoherencenearfE2rise,2)-mean(std(FemaleNewUR23CoherencenearfE2rise,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; ylim([0.2 .4]);
set(gca,'XTickLabels', [7  5 3  1  1  3  5  7  9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39],'fontsize',10)
set(gca,'XTick', [1:1440*2:1440*50],'fontsize',15);

%Aligning CRs Coherence by Fe2 rise looks like crap
figure;
plot(mean(FemaleNewCRCoherencenearfE2rise,2),'color',[0.0 0.6 1.0],'LineWidth',3);hold on; 
x=1:length(mean(FemaleNewCRCoherencenearfE2rise,2));a=fill([x fliplr(x)],[(mean(FemaleNewCRCoherencenearfE2rise,2)+mean(std(FemaleNewCRCoherencenearfE2rise,0,2),2)/sqrt(8))' flipud(mean(FemaleNewCRCoherencenearfE2rise,2)-mean(std(FemaleNewCRCoherencenearfE2rise,0,2),2)/sqrt(8))'],[0.0 0.3 1.0]); 
alpha(0.2); set(a,'EdgeColor','none'); axis tight; ylim([-2 2]);
set(gca,'XTickLabels', [7  5 3  1  1  3  5  7  9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39],'fontsize',10)
set(gca,'XTick', [1:1440*2:1440*50],'fontsize',15); ylim([0.5 0.9]);

%% Figure 3 Statistics Cycle by Day of Life Pattern

%% Figure 4. Plot Female and Male Temp Average by Day of LIfe alonside the fft


%% Figure 4 Multiweek Linear Trends

%% Figure 4 Stats
%% Intact female
clear movmeanfortrendfemale forMKtest 
FSFemales=[3 4 6 8 11 15 16 18];
figure;
 for i=1:8
     subplot(2,4,i);
     hold on;
 movmeanfortrendfemale(:,i)=movmean(pubertycohortfs2copy3{5,FSFemales(i)}(1440*5:end),1440); %removing the 1440 moving mean to see how the overall is affected
plot(movmean(movmeanfortrendfemale(:,i),1440),'color',[0.0 0.6 1.0],'LineWidth',2);
axis tight;title(FSFemales(i));ylim([36.75 38.0]);%ylim([-0.6 0.8]); 
set(gca,'XTickLabel', [26:4:84],'fontsize',10)
set(gca,'XTick', [1:1440*4:1440*72],'fontsize',10);
set(gca,'FontSize',12);
clear forMKtest
forMKtest=movmean(pubertycohortfs2copy3{5,FSFemales(i)}(1440*5:end),1440*4); %removed additional 4 day moving mean. I shouldn't layer them anyways
[H,mpearlytomidfemale(i)]=Mann_Kendall(forMKtest(1:1440:1440*16),0.05);  %mean of 2.0177e-4
[H,mpmidtolatefemale(i)]=Mann_Kendall(forMKtest(1440*16:1440:1440*32),0.05); % mean of 0.1567
[H,mpearlyadultfemale(i)]=Mann_Kendall(forMKtest(end-1440*16:1440:end),0.05);%mean of 0.1331

mearlytomidfemale(:,i)=forMKtest(1:1440:1440*16);
mmidtolatefemale(:,i)=forMKtest(1440*17:1440:1440*32);
mearlyadultfemale(:,i)=forMKtest(end-1440*15:1440:end);

%plot(forMKtest,'color',[0.0 0.6 1.0],'LineWidth',1);
FemaleMeans(i)=mean(forMKtest)
ylim([37 38]);
 end
 
%Overall Female Mean =37.36 
mpearlytomidfemale
mpmidtolatefemale
mpearlyadultfemale

%note p vals the same with non-zscored data
disp('mean of p vals early to mid puberty man kendall')
mean(mpearlytomidfemale) %%0.0040
disp('mean of p vals mid to late puberty man kendall')
mean(mpmidtolatefemale) % %0.0185
disp('mean of p vals early adult man kendall')
mean(mpearlyadultfemale) %%0.2813

%% Field Station Males
clear movmeanfortrendmale forMKtest mpearlytomidmale mpmidtolatemale mpearlyadultmale
FSMales=[1 2 5 7 9 10 14 17];
figure;
 for i=1:8;
     subplot(2,4,i);
     hold on;
 movmeanfortrendmale(:,i)=movmean(pubertycohortfs2copy3{5,FSMales(i)}(1440*5:end-60*8),1440); %removing the 1440 moving mean to see how the overall is affected
plot(movmean(movmeanfortrendmale(:,i),1440),'color',[0.5 0.0 0.1],'LineWidth',2);
axis tight;title(FSMales(i));ylim([37.0 38.0]);%ylim([36.75 38.5]);%ylim([-0.6 0.8]); 
set(gca,'XTickLabel', [26:4:84],'fontsize',10)
set(gca,'XTick', [1:1440*4:1440*72],'fontsize',10);
set(gca,'FontSize',12);
forMKtest=movmean(pubertycohortfs2copy3{5,FSMales(i)}(1440*5:end-60*8),1440*4); %removed additional 4 day moving mean. I shouldn't layer them anyways
[H,mpearlytomidmale(i)]=Mann_Kendall(forMKtest(1:1440:1440*16),0.05);  %mean of 2.0177e-4
[H,mpmidtolatemale(i)]=Mann_Kendall(forMKtest(1440*16:1440:1440*32),0.05); % mean of 0.1567
[H,mpearlyadultmale(i)]=Mann_Kendall(forMKtest(end-1440*16:1440:end),0.05);%mean of 0.1331

mearlytomidmale(:,i)=forMKtest(1:1440:1440*16);
mmidtolatemale(:,i)=forMKtest(1440*17:1440:1440*32);
mearlyadultmale(:,i)=forMKtest(end-1440*15:1440:end);

%plot(forMKtest,'color',[0.5 0.0 0.1],'LineWidth',1);
 end
 
mpearlytomidmale
mpmidtolatemale
mpearlyadultmale

%note p vals the same with non-zscored data
disp('mean of p vals early to mid puberty man kendall')
mean(mpearlytomidmale) %%0.0715
disp('mean of p vals mid to late puberty man kendall')
mean(mpmidtolatemale) % %0.1214
disp('mean of p vals early adult man kendall')
mean(mpearlyadultmale) %%0.2350

thingmeanmhiresfemale=movmean(mean(movmeanfortrendfemale,2),1440); 
stdevthingmhiresfemale=mean(std(movmeanfortrendfemale,0,2),2)/sqrt(8); %2 operates along columns, taking sliding dev for 1440 rows of these cols at a time
 
thingmeanmhiresmale=movmean(mean(movmeanfortrendmale,2),1440); 
stdevthingmhiresmale=mean(std(movmeanfortrendmale,0,2),2)/sqrt(8); %2 operates along columns, taking sliding dev for 1440 rows of these cols at a time


%plot the overall trends together;
figure; plot(thingmeanmhiresfemale,'color',[0 0.6 1],'LineWidth',3);
hold on;plot(thingmeanmhiresmale,'color',[0.5 0.0 0.1],'LineWidth',3);
set(gca,'XTickLabel',[26:8:74]); set(gca,'XTick',[1:1440*8:1440*72]);

set(gca,'XTickLabel', [  26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74 76 78 80 82 84 ],'fontsize',10)
%set(gca,'XTickLabel', [ 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75],'fontsize',10)
set(gca,'XTick', [  1 1440*2 1440*4 1440*6 1440*8 1440*10 1440*12 1440*14 1440*16 1440*18 1440*20 1440*22 1440*24 1440*26 1440*28 1440*30 1440*32 1440*34 1440*36 1440*38 1440*40 1440*42 1440*44 1440*46 1440*48 1440*50 1440*52 1440*54 1440*56 1440*58 1440*60 1440*62 1440*64 1440*66 1440*68 1440*70 1440*72 ],'fontsize',10);
set(gca,'FontSize',15);
axis tight;xlim([60*12 length(thingmeanmhiresfemale)-60*12]);
%ylim([-0.6 0.8]);
ylim([37.15 38.2]);

figure;
subplot(3,1,1); plot(thingmeanmhiresfemale,'color',[0 0.6 1],'LineWidth',3.5);hold on; 
x=1:length(stdevthingmhiresfemale);a=fill([x fliplr(x)],[(stdevthingmhiresfemale+thingmeanmhiresfemale)' flipud(thingmeanmhiresfemale-stdevthingmhiresfemale)'],[0.0 0.3 1.0]);
alpha(0.1); set(a,'EdgeColor','none'); axis tight;xlim([60*12 length(thingmeanmhiresfemale)-60*12]); 
ylim([37.15 38.2]);
%ylim([37.15 38.2]);%ylim([-0.6 0.8]);% %xlim([1440*4 1440*59.5]);
 set(gca,'XTickLabel', [  26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74 76 78 80 82 84 ],'fontsize',10)
%set(gca,'XTickLabel', [ 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75],'fontsize',10)
set(gca,'XTick', [  1 1440*2 1440*4 1440*6 1440*8 1440*10 1440*12 1440*14 1440*16 1440*18 1440*20 1440*22 1440*24 1440*26 1440*28 1440*30 1440*32 1440*34 1440*36 1440*38 1440*40 1440*42 1440*44 1440*46 1440*48 1440*50 1440*52 1440*54 1440*56 1440*58 1440*60 1440*62 1440*64 1440*66 1440*68 1440*70 1440*72 ],'fontsize',10);
set(gca,'FontSize',20);

subplot(3,1,2);
%thingmeanmbchiressmooth=figure;
 plot(thingmeanmhiresmale,'color',[0.5 0.0 0.0],'LineWidth',3.5);hold on; 
x=1:length(thingmeanmhiresmale);a=fill([x fliplr(x)],[(thingmeanmhiresmale+stdevthingmhiresmale)' flipud(thingmeanmhiresmale-stdevthingmhiresmale)'],[0.5 0.0 0.0]); 
alpha(0.1); set(a,'EdgeColor','none'); axis tight;xlim([60*12 length(thingmeanmhiresfemale)-60*12]);
ylim([37.15 38.2]);
%ylim([37.4 38.15]);%ylim([-0.6 0.8]);% %xlim([1440*4 1440*59.5]);
  set(gca,'XTickLabel', [ 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74 76 78 80 82 84 ],'fontsize',10)
%set(gca,'XTickLabel', [ 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75],'fontsize',10)
set(gca,'XTick', [  1 1440*2 1440*4 1440*6 1440*8 1440*10 1440*12 1440*14 1440*16 1440*18 1440*20 1440*22 1440*24 1440*26 1440*28 1440*30 1440*32 1440*34 1440*36 1440*38 1440*40 1440*42 1440*44 1440*46 1440*48 1440*50 1440*52 1440*54 1440*56 1440*58 1440*60 1440*62 1440*64 1440*66 1440*68 1440*70 1440*72 ],'fontsize',10);
set(gca,'FontSize',20);
  
subplot(3,1,3);
%thingmeanmbchiressmooth=figure;
 plot(thingmeanmhiresmale,'color',[0.5 0.0 0.0],'LineWidth',3.5);hold on; 
x=1:length(thingmeanmhiresmale);a=fill([x fliplr(x)],[(thingmeanmhiresmale+stdevthingmhiresmale)' flipud(thingmeanmhiresmale-stdevthingmhiresmale)'],[0.0 0.1 0.5]); 
alpha(0.1); set(a,'EdgeColor','none'); axis tight;xlim([60*12 length(thingmeanmhiresfemale)-60*12]);
plot(thingmeanmhiresfemale,'color',[0 0.6 1],'LineWidth',3.5);hold on; 
x=1:length(stdevthingmhiresfemale);a=fill([x fliplr(x)],[(stdevthingmhiresfemale+thingmeanmhiresfemale)' flipud(thingmeanmhiresfemale-stdevthingmhiresfemale)'],[0.0 0.3 1.0]);
alpha(0.1); set(a,'EdgeColor','none'); axis tight;xlim([60*12 length(thingmeanmhiresfemale)-60*12]); 
ylim([37.15 38.2]);
%ylim([37.4 38.15]);%ylim([-0.6 0.8]);% %xlim([1440*4 1440*59.5]);
  set(gca,'XTickLabel', [ 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74 76 78 80 82 84 ],'fontsize',10)
%set(gca,'XTickLabel', [ 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75],'fontsize',10)
set(gca,'XTick', [  1 1440*2 1440*4 1440*6 1440*8 1440*10 1440*12 1440*14 1440*16 1440*18 1440*20 1440*22 1440*24 1440*26 1440*28 1440*30 1440*32 1440*34 1440*36 1440*38 1440*40 1440*42 1440*44 1440*46 1440*48 1440*50 1440*52 1440*54 1440*56 1440*58 1440*60 1440*62 1440*64 1440*66 1440*68 1440*70 1440*72 ],'fontsize',10);
set(gca,'FontSize',20);

%% Figure 4 Violin Plots Sex Differences in Temp Level
%statistics run on the variables below; generated nmany blocks up for
%plottin the trends shown in figure 4a-c
%mearlytomidmale(:,i)=forcrMKtest(1:1440:1440*16);
%mmidtolatemale(:,i)=forcrMKtest(1440*17:1440:1440*32);
%mearlyadultmale(:,i)=forcrMKtest(end-1440*15:1440:end);

kw1=reshape(mearlytomidfemale,[16*8,1]);
kw2=reshape(mearlytomidmale,[16*8,1]);                           

figure;
subplot(3,1,1);
[h,L,MX,MED]=violin({kw1,kw2},'facecolor',[0.0 0.6 1.0;0.5 0.0 0.0],'edgecolor','k');
%title('early to mid');
ylim([36.7 38.8]);b = gca; legend(b,'off');set(gca,'xtick',[]);

[pearly,tblearly,statsearly]=friedman([kw1 kw2],16)
%Source           SS      df      MS      Chi-sq   Prob>Chi-sq
%-------------------------------------------------------------
%Columns        523.266     1   523.266   87.21    9.75429e-21
%Interaction    357.234    31    11.524                       
%Error          463.5     192     2.414                       
%Total         1344       255    

%with friedman = 16 since males aren't cycling . Results dont change much
%Source          SS      df      MS      Chi-sq   Prob>Chi-sq
%------------------------------------------------------------
%Columns        2232.6     1   2232.56   25.37    4.73214e-07
%Interaction   10031.9     7   1433.13                       
%Error          9559.5   240     39.83                       
%Total         21824     255   

%friedman = 16 huger. 
%Source          SS      df      MS      Chi-sq   Prob>Chi-sq
%------------------------------------------------------------
%Columns        6460.1     1   6460.14   73.41    1.05294e-17
%%Interaction    4814       7    687.71                       
%Error         10549.9   240     43.96                       
%Total         21824     255                                 

clear kw1 kw2
kw1=reshape(mmidtolatefemale,[16*8,1]);
kw2=reshape(mmidtolatemale,[16*8,1]);
                               
subplot(3,1,2);
[h,L,MX,MED]=violin({kw1,kw2},'facecolor',[0.0 0.6 1.0;0.5 0.0 0.1],'edgecolor','k');
%title('early to mid');
ylim([36.7 38.8]);b = gca; legend(b,'off');set(gca,'xtick',[]);

[pmidCR,tblmidCR,statsmidCR]=friedman([kw1 kw2],16)
%Source           SS      df      MS      Chi-sq   Prob>Chi-sq
%-------------------------------------------------------------
%Columns        203.063     1   203.063   33.84    5.97206e-09
%Interaction    716.938    31    23.127                       
%Error          424       192     2.208                       
%Total         1344       255 

%friedman=16
%Source         SS     df       MS      Chi-sq   Prob>Chi-sq
%-----------------------------------------------------------
%Columns        3364     1   3364       38.23    6.29662e-10
%Interaction    6169     7    881.286                       
%Error         12291   240     51.212                       
%Total         21824   255                                  

clear kw1 kw2
kw1=reshape(mearlyadultfemale,[16*8,1]);
kw2=reshape(mearlyadultmale,[16*8,1]);

subplot(3,1,3);
[h,L,MX,MED]=violin({kw1,kw2},'facecolor',[0.0 0.6 1.0;0.5 0.0 0.1],'edgecolor','k');
%title('early to mid');
ylim([36.7 38.8]);b = gca; legend(b,'off'); set(gca,'xtick',[]);

[padultCR,tbladultCR,statsadultCR]=friedman([kw1 kw2],16);

%Source           SS      df      MS      Chi-sq   Prob>Chi-sq
%-------------------------------------------------------------
%Columns        153.141     1   153.141   25.52    4.37042e-07
%Interaction    739.359    31    23.85                        
%Error          451.5     192     2.352                       
%Total         1344       255                                   

%% Stats for Figure 3 with thingmeanmhires and FemaleNewZURsnearfE2rise 4 day cycle pattern
%note to self: make sure to fresh run movmeanfortrend female block a couple
%blocks up -- this variable is getting redefined somehwere as cr or ur
%power and overwritten and the pattern isnt there in the overwritten data

for a=1:8
thing2testfor4day=FemaleNewZURsnearfE2rise(:,a);
%thing2testfor4day=movmeanfortrendmale(:,a);
%thing2testfor4day=MaleNewZURsnearfE2rise(:,a);
%thing2testfor4day=movmeanfortrendfemale(:,a);
clear cyclepatterntestdata
cyclepatterntestdata(:,3)=thing2testfor4day(1440*14:end); %length of thingmeanmhires minus 3 days of zerovals at the end
for i=1:1440*4:length(thing2testfor4day(1440*14:end));
cyclepatterntestdata(i:i+1439,2)=1;
cyclepatterntestdata(i+1440:i+1440*2-1,2)=2;
cyclepatterntestdata(i+1440*2:i+1440*3-1,2)=3;
cyclepatterntestdata(i+1440*3:i+1440*4-1,2)=4;
disp(i)
end
cyclepatterntestdata(1:1440*4,1)=1; 
cyclepatterntestdata(1440*4+1:1440*8,1)=2;
cyclepatterntestdata(1440*8+1:1440*12,1)=3;
cyclepatterntestdata(1440*12+1:1440*16,1)=4;
cyclepatterntestdata(1440*16+1:1440*20,1)=5;
cyclepatterntestdata(1440*20+1:1440*24,1)=6;
cyclepatterntestdata(1440*24+1:1440*28,1)=7;
cyclepatterntestdata(1440*28+1:1440*32,1)=8;
%cyclepatterntestdata(1440*32+1:1440*36,1)=9;
%cyclepatterntestdata(1440*40+1:1440*44,1)=10;
%figure;plot(cyclepatterntestdata);

clear day1 day2 day3 day4
for i=1:length(cyclepatterntestdata);
    if cyclepatterntestdata(i,2)==1;
        day1(i)=cyclepatterntestdata(i,3);
    end
end
for i=1:length(cyclepatterntestdata);
 if cyclepatterntestdata(i,2)==2;
        day2(i)=cyclepatterntestdata(i,3);
 end
end

for i=1:length(cyclepatterntestdata);
   if cyclepatterntestdata(i,2)==3;
        day3(i)=cyclepatterntestdata(i,3);
   end 
end
for i=1:length(cyclepatterntestdata);
  if cyclepatterntestdata(i,2)==4;
        day4(i)=cyclepatterntestdata(i,3);
  end 
end

day1(day1==0)=[];sort(day1);%figure;plot(movmean(day1,1440)); hold on;
day2(day2==0)=[];sort(day2);%hold on;plot(movmean(day2,1440));
day3(day3==0)=[];sort(day3);%plot(movmean(day3,1440));
day4(day4==0)=[];sort(day4);%plot(movmean(day4,1440));

day1mm=movmean(day1,1440);
day2mm=movmean(day2,1440);
day3mm=movmean(day3,1440);
day4mm=movmean(day4,1440);
[pcycle(a),tblcycle,statscycle]=friedman([day1mm(1:60*24:length(day4))',day2mm(1:60*24:length(day4))',day3mm(1:60*24:length(day4))',day4mm(1:60*24:length(day4))'],2)
%[pcycle(a),tblcycle,statscycle]=friedman([day1mm(1:60*24:length(day4))',day3mm(1:60*24:length(day4))'],2)

%multcompare(statscycle)
end


median(pcycle)
%5.1e-04 for Female URs/ 0.0336 for 1 val per day
%8.45e-05 for Female Temps/0.005 for val per day/1 val per day day 1 v 3
%p=0.0576
% 0.1983 for Male Temps
%0.1688 for Male URs

LinTempChisFemale=[12.33,13.67,16.2,12.33,2.73,5.4,16.2,13];
mean(LinTempChisFemale)
median(LinTempChisFemale)
LinTempChisMale=[5.64,19.8,0.65,9.53,9.82,18.17,15.58,2.23];
mean(LinTempChisMale)
median(LinTempChisMale)
URTempChisMale=[3.4,3.8,1,6.6,4.2,1,2.6,3.4];
mean(URTempChisMale)
URTempChisFemale=[10.95,13.95,2.85,10.95,7.05,8.85,8.55,6.75]
mean(URTempChisFemale) %8.75
%group 60 min res kruskal wallis results
%Source        SS        df       MS       Chi-sq   Prob>Chi-sq
%--------------------------------------------------------------
%Columns    4.2063e+06     3   1402098.9   110.29   9.49288e-24
%Error     2.15366e+07   672     32048.6                       
%Total     2.57429e+07   675    
 
%   1.0000    2.0000 -113.5071  -58.9290   -4.3509 0.02
%    1.0000    3.0000 -243.0396 -188.4615 -133.8835 0
%    1.0000    4.0000 -228.6905 -174.1124 -119.5344 0
%    2.0000    3.0000 -184.1106 -129.5325  -74.9545 0
%    2.0000    4.0000 -169.7615 -115.1834  -60.6054 0 
%    3.0000    4.0000  -40.2290   14.3491   68.9272 0.90


[pcycle,tblcycle,statscycle]=friedman([day1(1:60:length(day4))',day2(1:60:length(day4))',day3(1:60:length(day4))',day4(1:60:length(day4))'])
%Source      SS      df      MS      Chi-sq   Prob>Chi-sq
%--------------------------------------------------------
%Columns   277.805     3   92.6016   166.68   6.61834e-36
%Error     567.195   504    1.1254                       
%Total     845       675                                 

multcompare(statscycle)

%    1.0000    2.0000   -0.7809   -0.4201   -0.0593    0.0147
%    1.0000    3.0000   -1.9999   -1.6391   -1.2783    0.0000
%    1.0000    4.0000   -1.5561   -1.1953   -0.8345    0.0000
%    2.0000    3.0000   -1.5797   -1.2189   -0.8581    0.0000
%    2.0000    4.0000   -1.1359   -0.7751   -0.4143    0.0000
%    3.0000    4.0000    0.0830    0.4438    0.8046    0.0086
%% A different fT Rise day for males - nope not worth it
%just add note that t did slope upward a bit before that
figure;
for i=1:18
    subplot(6,3,i); hold on;
    plot(pubertycohortfs2copy3{27,i}(:,1),pubertycohortfs2copy3{27,i}(:,2),'color','k');
    title(i)
end
%% Supplemental Figures


%% Supplemental Fig 1 - Distribution of Days of VO, fE2, PrepSep and fT ; no stats

%make distribution variable for plotting from -6 to 5
HistVOMinusE2Rise=[1 1 0 1 2 0 3 1 0 0 0 0];

%hist of day of fE2 rise
HistfE2=[2 1 3 1 1 0]; %
DayfE2=[ 33 33 36 35 35 35 34 37 35]

%hist of day of VO
HistVO=[0 1 1 2 2 1 1]; 
DayVO=[ 38 39 36 35 34 38 36 37 37 ]


figure;
subplot(2,2,1);
bar(HistVO,'FaceColor',[0.0 0.6 1.0],'EdgeAlpha',0.05); alpha(0.5);hold on;
ylim([ 0 4]); 
set(gca,'XTick', [0:2:6],'fontsize',10)
set(gca,'XTickLabel', [32:2:38],'fontsize',10);
set(gca,'FontSize',15); %title('VO Days');

subplot(2,2,2);
bar(HistfE2,'FaceColor',[0.0 0.6 1.0],'EdgeAlpha',0.05); alpha(0.5);hold on;
ylim([ 0 4]); 
set(gca,'XTick', [0:2:6],'fontsize',10)
set(gca,'XTickLabel', [32:2:38],'fontsize',10);
set(gca,'FontSize',15); %title ('fE2 Rise Days')

%hist of day of Preputial Separation
Histprepsep=[1 3 1 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; 
Dayprepsep=[ 43 43 43 41 41 41 40 42 ]

%hist of day of fT rise
HistfT=[0 0 0 0 0 0 0 0 0 1 0 2 0 0 3 0 0 1 1]; 
DayfT=[ 54 54 51 54 51 58 57 49]



%figure;
subplot(2,2,3);
bar(Histprepsep,'FaceColor',[0.5 0.0 0.0],'EdgeAlpha',0.05); alpha(0.5);hold on;
ylim([ 0 4]); 
set(gca,'XTick', [0:4:18],'fontsize',10)
set(gca,'XTickLabel', [40:4:58],'fontsize',10);
set(gca,'FontSize',15); %title('Preputial Sep');

subplot(2,2,4);
bar(HistfT,'FaceColor',[0.5 0.0 0.0],'EdgeAlpha',0.05); alpha(0.5);hold on;
ylim([ 0 4]); 
set(gca,'XTick', [0:4:18],'fontsize',10)
set(gca,'XTickLabel', [40:4:58],'fontsize',10);
set(gca,'FontSize',15); %title ('fT Rise Days')

figure;

for i=1:8
subplot(2,1,1);
ColormapInterval=8;%length(allData{i});
clear AzureM 
AzureMRed=[0.6843:-(0.6/(ColormapInterval-1)):0.0843];
AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);
t=scatter(DayVO(i),DayfE2(i),100,[0 0.6 1],'filled'); hold on;
t.MarkerFaceAlpha=0.4;t.MarkerEdgeAlpha=0.8;
setMarkerColor(t,AzureM(i,:),1); xlim([33 40]); ylim([33 40]);
set(gca,'box','on');
subplot(2,1,2);

clear AzureM  
AzureMRed=[0.9843:-(0.9/(ColormapInterval-1)):0.0843];
AzureMGreen=[ 0 0 0 0 0 0 0 0];%AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[0 0 0 0 0 0 0 0];%[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);
s=scatter(Dayprepsep(i),DayfT(i),100,[0.5 0.0 0.0],'filled'); hold on;
s.MarkerFaceAlpha=0.4;s.MarkerEdgeAlpha=0.8;
setMarkerColor(s,AzureM(i,:),1); ylim([40 59]); xlim([40 59]);

set(gca,'box','on');
disp(i)
end


ColormapInterval=7;%length(allData{i});
clear AzureM  
AzureMRed=[0.9843:-(0.9/(ColormapInterval-1)):0.0843];
AzureMGreen=[ 0 0 0 0 0 0 0];%AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[0 0 0 0 0 0 0];%[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);


%why the eff am i plotting the median CR power from 18 days earlier??
t=scatter(pubertycohortfs2copy3{27,FSMales(i)}(j,2),circadianmediantoplot,100,[0.5 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.4;t.MarkerEdgeAlpha=0.8;ylim([0 0.8]); xlim([0 10000]);%xlim([ -3 3]);%xlim([0 5000]);
setMarkerColor(t,AzureM(j-6,:),1);

%% Potentially For Supplement Linear Plot of All Individuals' fE2 and fT
%Plot linear 2D Raw E2 and T Values
figure;
for i=1:8
    subplot(2,5,i);
    plot(pubertycohortfs2copy3{27,FSFemales(i)}(:,1),pubertycohortfs2copy3{27,FSFemales(i)}(:,2),'color',[0.0 0.6 1.0]);
title(FSFemales(i));
end

figure;
for i=[1:5,7:8]
    subplot(2,4,i);
    plot(pubertycohortfs2copy3{27,FSMales(i)}(:,1),pubertycohortfs2copy3{27,FSMales(i)}(:,2),'color',[0.5 0.0 0.0]);
title(FSMales(i));
end


%% Supp Fig 2: Copying weight supplement over from NAF Paper
%% Supp Fig 2: Weight progression uninterpolated

figure; hold on;
for i=1:8
   
    ColormapInterval=8;%length(allData{i});
clear AzureM 
AzureMRed=[0.6843:-(0.6/(ColormapInterval-1)):0.0843];
AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);

    plot(pubertycohortfs2copy3{31,FSFemales(i)}(1:46,2),'color',AzureM(i,:),'LineWidth',3);
    
clear AzureM  
AzureMRed=[0.9843:-(0.9/(ColormapInterval-1)):0.0843];
AzureMGreen=[ 0 0 0 0 0 0 0 0];%AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[0 0 0 0 0 0 0 0];%[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);
 
    
    plot(pubertycohortfs2copy3{31,FSMales(i)}(1:46,2),'color',AzureM(i,:),'LineWidth',3);
  disp(i)
end
  set(gca,'XTickLabels', [21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75],'fontsize',10)
set(gca,'XTick', [1:2:72],'fontsize',10);axis tight;
title(' ');ylim([30 400]);


ColormapInterval=8;%length(allData{i});
clear AzureM 
AzureMRed=[0.6843:-(0.6/(ColormapInterval-1)):0.0843];
AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);
t=scatter(DayVO(i),DayfE2(i),100,[0 0.6 1],'filled'); hold on;
t.MarkerFaceAlpha=0.4;t.MarkerEdgeAlpha=0.8;
setMarkerColor(t,AzureM(i,:),1); xlim([33 40]); ylim([33 40]);
set(gca,'box','on');
subplot(2,1,2);

clear AzureM  
AzureMRed=[0.9843:-(0.9/(ColormapInterval-1)):0.0843];
AzureMGreen=[ 0 0 0 0 0 0 0 0];%AzureMGreen=[0.9157:-(0.6/(ColormapInterval-1)):0.3157];
AzureMBlue=[0 0 0 0 0 0 0 0];%[(0.9882:-(0.5/(ColormapInterval-1)):0.4882)];
%figure;hold on; plot(AzureMBlue,'b');plot(AzureMGreen,'g');plot(AzureMRed,'r');
AzureM=[AzureMRed'  AzureMGreen' AzureMBlue']; %colorbar=figure; imagesc([1:1:48]);colormap(AzureM);
s=scatter(Dayprepsep(i),DayfT(i),100,[0.5 0.0 0.0],'filled'); hold on;
s.MarkerFaceAlpha=0.4;s.MarkerEdgeAlpha=0.8;
setMarkerColor(s,AzureM(i,:),1); ylim([40 59]); xlim([40 59]);


%% Supplemental Weight 2 Figure rewrite xvalues of column 30 with last length(30) of column 29

for a=1:32
    pubertycohortnaf{30,a}(:,1)=pubertycohortnaf{29,a}(1+length(pubertycohortnaf{29,a})-length(pubertycohortnaf{30,a}):end,1);
    disp(a)
end

%% Supplemental Figure 2 create daily interpolated weights
figure;
for a=1:32
    clear matrix matrix2 idx2 idx MATLABDate Tempfile tempfit ending start interval TempString
matrix=[pubertycohortnaf{30,a}(:,1), pubertycohortnaf{30,a}(:,2)]; 
[~,idx2] = unique(matrix(:,1));   %which rows have a unique first value?
matrix2 = matrix(idx2,:);  %only use those
MATLABDate=matrix2(:,1); Tempfile=matrix2(:,2);
idx = isfinite(pubertycohortnaf{30,a}(:,2)); %isfinite(MATLABDate) & 
MATLABDate=MATLABDate(idx); Tempfile=pubertycohortnaf{30,a}(idx,2);% will this result in mismatching lenghts or did the & above correct for this
tempfit=fit(MATLABDate,Tempfile,'linearinterp');
ending=MATLABDate(end); start=MATLABDate(1); interval=(start:1:ending); TempString=feval(tempfit, interval); 
subplot(4,8,a); plot(TempString); title(a); 
  set(gca,'XTickLabels', [21  25 29  33  37  41  45  49  53  57  61  65  69  73 77],'fontsize',10)
set(gca,'XTick', [2:4:72],'fontsize',5);title(a);ylim([30 350]);
pubertycohortnaf{31,a}(:,1)=TempString;
end

%% Supplemental Figure:2  Plotting the Interpolated Weights and Statistics

figure; hold on;
for i=1:7
     plot(pubertycohortnaf{31,new5m(i)}(:,1),'color',[0.0 0.6 1.0],'LineWidth',3);
     plot(pubertycohortnaf{31,new5mbc(i)}(:,1),'color',[0.0 0.3 0.5],'LineWidth',3);
     plot(pubertycohortnaf{31,oxsham(i)}(:,1),'color',[0.7 0.6 0.6],'LineWidth',3);
     plot(pubertycohortnaf{31,oxE2(i)}(:,1),'color',[0.8100 0.3100 0.0700],'LineWidth',3);
  disp(i)
  
end
  set(gca,'XTickLabels', [21  25 29  33  37  41  45  49  53  57  61  65  69  73 77],'fontsize',10)
set(gca,'XTick', [2:4:72],'fontsize',15);title(a);ylim([30 350]); xlim([1 60]);

mweights=1;mweightsdays=1;
mbcweights=1;mbcweightsdays=1;
oxshamweights=1;oxshamweightsdays=1;
oxE2weights=1;oxE2weightsdays=1;

for i=1:7
    mweights(length(mweights):length(mweights)+length(pubertycohortnaf{30,newnewnewm(i)})-1,2)=pubertycohortnaf{30,newnewnewm(i)}(:,2);
mweightsdays(length(mweightsdays):length(mweightsdays)+length(pubertycohortnaf{30,newnewnewm(i)})-1,1)=pubertycohortnaf{30,newnewnewm(i)}(1:length(pubertycohortnaf{30,newnewnewm(i)}(:,1)),1);
    mbcweights(length(mbcweights):length(mbcweights)+length(pubertycohortnaf{30,newnewmbc(i)})-1,2)=pubertycohortnaf{30,newnewmbc(i)}(:,2);
mbcweightsdays(length(mbcweightsdays):length(mbcweightsdays)+length(pubertycohortnaf{30,newnewmbc(i)})-1,1)=pubertycohortnaf{30,newnewmbc(i)}(1:length(pubertycohortnaf{30,newnewmbc(i)}(:,1)),1);
    oxshamweights(length(oxshamweights):length(oxshamweights)+length(pubertycohortnaf{30,oxsham(i)})-1,2)=pubertycohortnaf{30,oxsham(i)}(:,2);
oxshamweightsdays(length(oxshamweightsdays):length(oxshamweightsdays)+length(pubertycohortnaf{30,oxsham(i)})-1,1)=pubertycohortnaf{30,oxsham(i)}(1:length(pubertycohortnaf{30,oxsham(i)}(:,1)),1);
    oxE2weights(length(oxE2weights):length(oxE2weights)+length(pubertycohortnaf{30,oxE2(i)})-1,2)=pubertycohortnaf{30,oxE2(i)}(:,2);
oxE2weightsdays(length(oxE2weightsdays):length(oxE2weightsdays)+length(pubertycohortnaf{30,oxE2(i)})-1,1)=pubertycohortnaf{30,oxE2(i)}(1:length(pubertycohortnaf{30,oxE2(i)}(:,1)),1);
disp(i)
end

figure;plot(mweightsdays,mweights(:,2));
figure;plot(mbcweightsdays,mbcweights(:,2));
figure;plot(oxshamweightsdays,oxshamweights(:,2));
figure;plot(oxE2weightsdays,oxE2weights(:,2));

mweightsforsort=[mweightsdays,mweights(:,2)];
mbcweightsforsort=[mbcweightsdays,mbcweights(:,2)];
oxshamweightsforsort=[oxshamweightsdays,oxshamweights(:,2)];
oxe2weightsforsort=[oxE2weightsdays,oxE2weights(:,2)];


mweightssorted=sortrows(mweightsforsort); %sort weights by day of life (e.g., cluster all the day 20's together). 
mbcweightssorted=sortrows(mbcweightsforsort);
oxshamweightssorted=sortrows(oxshamweightsforsort);
oxe2weightssorted=sortrows(oxe2weightsforsort);

mweightssorted(sum(isnan(mweightssorted),2)==1,:)=[]; %try to find rows with a nan and delete them.
mbcweightssorted(sum(isnan(mbcweightssorted),2)==1,:)=[]; %try to find rows with a nan and delete them.
oxshamweightssorted(sum(isnan(oxshamweightssorted),2)==1,:)=[]; %try to find rows with a nan and delete them.
oxe2weightssorted(sum(isnan(oxe2weightssorted),2)==1,:)=[]; %try to find rows with a nan and delete them.

%early life chunk weight comparison

clear group
group(1:89)=1; group(90:169)=2;group(170:249)=3; group(249:329)=4;
[pearlyweight,tblearlyweight,statsearlyweight]=kruskalwallis([mweightssorted(1:89,2)',mbcweightssorted(1:80,2)',oxshamweightssorted(1:80,2)',oxe2weightssorted(1:80,2)'],group)
correction=multcompare(statsearlyweight)

%Source      SS       df      MS      Chi-sq   Prob>Chi-sq
%---------------------------------------------------------
%Groups     42830.8     3   14276.9    4.73      0.1923   
%Error    2924235.7   325    8997.6                       
%Total    2967066.5   328     

%    1.0000    2.0000  -18.3141   19.3302   56.9745    0.5506
%    1.0000    3.0000  -16.6864   21.0832   58.8528    0.4780
%    1.0000    4.0000   -6.7346   30.7871   68.3089    0.1505
%    2.0000    3.0000  -37.0028    1.7530   40.5088    0.9994
%    2.0000    4.0000  -27.0573   11.4569   49.9712    0.8706
%    3.0000    4.0000  -28.9328    9.7039   48.3406    0.9172


%mid life chunk weight comparison
clear group
group(1:37)=1; group(38:90)=2;group(91:146)=3; group(147:205)=4;
[pearlyweight,tblearlyweight,statsearlyweight]=kruskalwallis([mweightssorted(89:126,2)',mbcweightssorted(101:153,2)',oxshamweightssorted(102:157,2)',oxe2weightssorted(102:159,2)'],group)
correction=multcompare(statsearlyweight)

%oxsham significantly higher than all other groups

%Source      SS      df      MS      Chi-sq   Prob>Chi-sq
%--------------------------------------------------------
%Groups   203702.1     3   67900.7    57.9    1.65234e-12
%Error    514023.9   201    2557.3                       
%Total    717726     204                                  

%    1.0000    2.0000  -50.4734  -17.8284   14.8166    0.4974
%    1.0000    3.0000 -116.0767  -83.7932  -51.5097    0.0000
%    1.0000    4.0000  -86.9880  -55.0328  -23.0775    0.0001
%    2.0000    3.0000  -95.1670  -65.9648  -36.7626    0.0000
%    2.0000    4.0000  -66.0433  -37.2043   -8.3654    0.0051
%    3.0000    4.0000    0.3314   28.7604   57.1895    0.0462

clear group
group(1:55)=1; group(56:108)=2;group(109:131)=3; group(132:156)=4;
[pearlyweight,tblearlyweight,statsearlyweight]=kruskalwallis([mweightssorted(127:181,2)',mbcweightssorted(154:207,2)',oxshamweightssorted(158:181,2)',oxe2weightssorted(160:182,2)'],group)
correction=multcompare(statsearlyweight)

%Source      SS      df      MS      Chi-sq   Prob>Chi-sq
%--------------------------------------------------------
%Groups   155308.9     3   51769.6   76.13    2.07749e-16
%Error    160911.1   152    1058.6                       
%Total    316220     155                                                               
    
%correction =
%    1.0000    2.0000  -17.5006    4.8346   27.1699    0.9449
%    1.0000    3.0000  -93.9320  -65.1182  -36.3044    0.0000
%    1.0000    4.0000  -94.5075  -66.5182  -38.5289    0.0000
%   2.0000    3.0000  -98.9265  -69.9528  -40.9792    0.0000
%    2.0000    4.0000  -99.5067  -71.3528  -43.1990    0.0000
%    3.0000    4.0000  -34.9263   -1.4000   32.1263    0.9996

