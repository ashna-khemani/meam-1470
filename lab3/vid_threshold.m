%% 147 Lab Code 
%_Authors: Arjun Kumar, Christopher Kim  

% put correct video name
v_in = "spring.mp4";

% gen output vid name
path = split(v_in, '.');
assert(length(path) == 2, "no '.' in filename")
v_out = path(1) + '_out'; 

%  gen thresholded video
v = VideoReader(v_in);
vo = VideoWriter(v_out);
vo.FrameRate = v.FrameRate;

open(vo);

wb = waitbar(0, 'Generating Video');
n_frames = v.NumFrames;
current_frame = 0;
while hasFrame(v)
   frame = readFrame(v);
   [BW,maskedRGBImage] = createMask(frame);
   out_frame = uint8(BW) * 255;
   writeVideo(vo, out_frame);
    
   current_frame = current_frame + 1;
   waitbar(current_frame/n_frames, wb, 'Generating Video');
end

close(wb)
close(vo);


