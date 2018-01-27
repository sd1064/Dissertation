X = [outputOne(1,1);outputTwo(1,1)];
Y = [outputOne(1,2);outputTwo(1,2)];
Z = [outputOne(1,3);outputTwo(1,3)];

figure;hold on;axis equal;grid on;
plot3(X,Y,Z,'g*');

view([-180 90])

cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',20);


xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');

txt1 = 'Sphere One';
txt2 = 'Sphere Two';

text(outputOne(1,1),outputOne(1,2),outputOne(1,3),txt1);
text(outputTwo(1,1),outputTwo(1,2),outputTwo(1,3),txt1);
