%% 147 Lab Code 
%_Authors: Arjun Kumar, Christopher Kim  

% enter correct thresholded video name
v_in = "video3_out.avi";
% enter scale in meters/pixel
calibration_scale = 0.04/69;
% 0:output in (frame, pixels), >0:output in (seconds, meters)

clc;
close all;

box_data = gTruth.LabelData.box;
pos = cell2mat(box_data(:,1));
label_frames = length(pos(:, 1));

%  Video
v = VideoReader(v_in);
assert(label_frames == v.NumFrames, "Incorrect video for Labels")
fps = v.FrameRate;

px = zeros(label_frames, 1);
py = zeros(label_frames, 1);

for f_idx = 1:label_frames
   frame = readFrame(v);
   frame = frame(:, :, 1) > 0;
   
   mask = insertShape(zeros(v.Height, v.Width, 3), 'FilledRectangle', [pos(f_idx, :)], 'Color', 'white');
   mask = mask(:, :, 1) > 0;
   temp_frame = uint8(mask & frame) * 255;
    
   [xx, yy] = ind2sub(size(temp_frame), find(temp_frame));
   X = [xx, yy];
   [id, C] = kmeans(X, 1);
   out_frame = cat(3, temp_frame, temp_frame, temp_frame);
   show_frame = insertShape(out_frame,'circle',[C(2) C(1) 20],'LineWidth',5, 'Color', 'red'); 

   px(f_idx) = C(2);
   py(f_idx) = size(temp_frame, 1) - C(1);

   imshow(show_frame);
end



if calibration_scale > 0
    t = (1:label_frames)*(1/fps); %#ok<UNRCH>
    px_label_string = 'time(seconds)';
    py_label_string = 'position(meters)';
    vx_label_string = 'time(seconds)';
    vy_label_string = 'velocity(m/s)';
    px = px * calibration_scale;
    py = py * calibration_scale;
else
    t = (1:label_frames); %#ok<UNRCH>
    px_label_string = 'time(frames)';
    py_label_string = 'position(pixels)';
    vx_label_string = 'time(frames)';
    vy_label_string = 'velocity(px/frame)';
end


%calc velocities
t_diff = t(3:end) - t(1:end-2);
vx = (px(3:end) - px(1:end-2)) ./ t_diff;
vy = (py(3:end) - py(1:end-2)) ./ t_diff;



figure(1);
subplot(2, 2, 1);
plot(t ,px, 'b')
xlabel(px_label_string)
ylabel(py_label_string)
title('X Position')
subplot(2, 2, 3);
plot(t, py, 'b')
xlabel(px_label_string)
ylabel(py_label_string)
title('Y Position')
subplot(2, 2, 2);
plot(t(2:end-1) ,vx, 'r')
xlabel(vx_label_string)
ylabel(vy_label_string)
title('X Velocity')
subplot(2, 2, 4);
plot(t(2:end-1), vy, 'r')
xlabel(vx_label_string)
ylabel(vy_label_string)
title('Y Velocity')
