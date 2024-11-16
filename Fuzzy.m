airplane = sugfis;
airplane = addInput(airplane,[-5 5],'Name','HT');
airplane = addInput(airplane,[-10 10],'Name','PI');
airplane = addMF(airplane,'HT','trimf',[-10 -5 -0],'Name','HD');
airplane = addMF(airplane,'HT','trimf',[-3 0 3],'Name','HZ');
airplane = addMF(airplane,'HT','trimf',[0 5 10],'Name','HU');
airplane = addMF(airplane,'PI','trimf',[-15 -10 0],'Name','PL');
airplane = addMF(airplane,'PI','trimf',[-10 0 10],'Name','PZ');
airplane = addMF(airplane,'PI','trimf',[0 10 15],'Name','PH');
figure
subplot(1,2,1)
plotmf(airplane,'input',1)
title('Horizontal Tail Angle')
subplot(1,2,2)
plotmf(airplane,'input',2)
title('Pitch Angle')
airplane = addOutput(airplane,[-1 1],'Name','DHT');
airplane = addMF(airplane,'DHT','constant',-1,'Name','HDD');
airplane = addMF(airplane,'DHT','constant',-0.5,'Name','HD');
airplane = addMF(airplane,'DHT','constant',0,'Name','ZO');
airplane = addMF(airplane,'DHT','constant',0.5,'Name','HU');
airplane = addMF(airplane,'DHT','constant',1,'Name','HUU');
rules = [
    "HT==HD & PI==PL => DHT=ZO";
    "HT==HD & PI==PZ => DHT=HU";
    "HT==HD & PI==PH => DHT=HUU";
    "HT==HZ & PI==PL => DHT=HD";
    "HT==HZ & PI==PZ => DHT=ZO";
    "HT==HZ & PI==PH => DHT=HU";
    "HT==HU & PI==PL => DHT=HDD";
    "HT==HU & PI==PZ => DHT=HD";
    "HT==HU & PI==PH => DHT=ZO";
    ];
airplane = addRule(airplane,rules);
figure
gensurf(airplane)
title('Control surface of airplane horizontal tail')
fis2 = convertToType2(airplane);
figure
gensurf(fis2)
title('Control surface of type2')

Vp = sugfis;
Vp = addInput(Vp,[-5 5],'Name','VT');
Vp = addInput(Vp,[-10 10],'Name','Yaw');
Vp = addMF(Vp,'VT','trimf',[-8 -5 -2],'Name','VL');
Vp = addMF(Vp,'VT','trimf',[-3 0 3],'Name','VZ');
Vp = addMF(Vp,'VT','trimf',[2 5 8],'Name','VR');
Vp = addMF(Vp,'Yaw','trimf',[-16 -10 -4],'Name','YR');
Vp = addMF(Vp,'Yaw','trimf',[-10 0 10],'Name','YC');
Vp = addMF(Vp,'Yaw','trimf',[4 10 16],'Name','YL');
Vp = addOutput(Vp,[-1 1],'Name','DVT');
Vp = addMF(Vp,'DVT','constant',-1,'Name','VRR');
Vp = addMF(Vp,'DVT','constant',-0.5,'Name','VR');
Vp = addMF(Vp,'DVT','constant',0,'Name','VZ');
Vp = addMF(Vp,'DVT','constant',0.5,'Name','VL');
Vp = addMF(Vp,'DVT','constant',1,'Name','VLL');
subplot(2,2,1)
plotmf(Vp,'input',1)
title('Vertical Tail Angle')
subplot(2,2,2)
plotmf(Vp,'input',2)
title('Yaw Angle')
ruleset2 = [
    "VT==VL & Yaw==YL => DVT=VZ";
    "VT==VL & Yaw==YC => DVT=VR";
    "VT==VL & Yaw==YR => DVT=VRR";
    "VT==VZ & Yaw==YL => DVT=VL";
    "VT==VZ & Yaw==YC => DVT=VZ";
    "VT==VZ & Yaw==YR => DVT=VR";
    "VT==VR & Yaw==YL => DVT=VLL";
    "VT==VR & Yaw==YC => DVT=VL";
    "VT==VR & Yaw==YR => DVT=VZ";
    ];
Vp = addRule(Vp,ruleset2);
figure
gensurf(Vp)
title('Control surface of airplane vertical tail')
Vpt2 = convertToType2(Vp);
scale = [0.1 0.8 0.2;0.05 0.95 0.05];
for i = 1:length(Vpt2.Inputs)
    for j = 1:length(Vpt2.Inputs(i).MembershipFunctions)
        Vpt2.Inputs(i).MembershipFunctions(j).LowerLag = 0;
        Vpt2.Inputs(i).MembershipFunctions(j).LowerScale = scale(i,j);
    end
end
figure
subplot(2,2,1)
plotmf(Vpt2,'input',1)
title('Input 1')
subplot(2,2,2)
plotmf(Vpt2,'input',2)
title('Input 2')
figure
gensurf(Vpt2)
title('Control surface of type2 Vertical Tail')