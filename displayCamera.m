%TO DO SHOW SPHERE AND CAMERA 
X = [outputOne(1,1);outputTwo(1,1)];
Y = [outputOne(1,2);outputTwo(1,2)];
Z = [outputOne(1,3);outputTwo(1,3)];

figure;
plot3(X,Y,Z,'g*');
hold on
orientation = eye(3);
location = [0 ; 0 ; 0 ];
cam = plotCamera('Location',location,'Orientation',orientation,'Size',20);
set(gca,'CameraUpVector',[0 0 -1]);
camorbit(gca,-110,60,'data',[0 0 1]);

axis equal
grid on
cameratoolbar('SetMode','orbit');

xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');

xlim([-outputOne(1,1)*0.25 outputOne(1,1)*1.5 ]);
ylim([-outputOne(1,2)*1.5 outputOne(1,2)*1.5 ]);
zlim([0 outputOne(1,3)*1.5 ]);

txt1 = 'Sphere One';
txt2 = 'Sphere Two';

text(outputOne(1,1),outputOne(1,2),outputOne(1,3),txt1);
text(outputTwo(1,1),outputTwo(1,2),outputTwo(1,3),txt1);
