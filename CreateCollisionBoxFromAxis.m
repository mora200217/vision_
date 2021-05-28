
function cb = CreateCollisionBoxFromAxis(axes)
%% Axis parameters extraction
p_0 = axes(1:3);
p_1 = axes(4:6); 

orientationVect = (p_1 - p_0) .* [1 1 1]; 
n = norm(orientationVect); 

% rotacion 
ax = cross([0,0,1], orientationVect); 
theta = acos(orientationVect(3) / n); 



center = 0.5 * (p_0 + p_1); 
x = center(1); % (mm)
y = center(2); % (mm)
z = center(3); % (mm)
%% Parameters
% angles = [ beta alpha gamma]; % Euler Angles 
position = [ x y z];  % Centroid Position 
%% Transformations
disp(ax)
rotm = axang2rotm([ax theta]);
th = trvec2tform(position) *  rotm2tform(rotm); % Create 
%% Box Collision parameters

H= 100;  % Height  (mm)
R = 25 ; % Radius (mm)

% Create collision box -------------
cb = collisionBox(2 * R , 2 * R, H); 
cb.Pose = th % State the new pose from Homogenous trans. 
disp(th); 
% show(cb)
end 