

%Ball follower using PC's serial port
clc                                     % clear the command prompt
fprintf('wait please');                 % to print a string in command prompt
imaqreset                               % disconnect and delete all image aquisition objects
clear all                               % clear variable and functions from memory
vidobj = videoinput('winvideo',2,'YUY2_320x240');      % creates a video input object
set(vidobj,'FramesPerTrigger',1);       % set the property of a object
set(vidobj,'TriggerRepeat',inf);        
triggerconfig(vidobj,'manual');         % configure video input object trigger setting
start(vidobj);                          % Start timer(s) running.


s = serial('COM20', 'BaudRate', 9600);
set(s,'outputbuffersize',1024);
fopen(s);


while(1)
    %image=vfm('grab');
    trigger(vidobj);                    % Manually initiate logging/sending for running object.
    frame=getdata(vidobj);              % Return acquired data samples from engine to MATLAB workspace.
    image_ycbcr=rgb2ycbcr(frame);       % Convert RGB values to YCBCR color space.
    image_cb=image_ycbcr(:,:,2);
    image_cr=image_ycbcr(:,:,3);
    [r c d]=size(image_ycbcr);
    output_image=zeros(r,c);
    for i1=1:r
        for i2=1:c
               if ((image_cb(i1,i2)==128)&&  (image_cr(i1,i2)==128))    %for orange bal
                output_image(i1,i2)=1;
            else
                output_image(i1,i2)=0;
            end
        end
    end
    
   imshow(output_image);
   [r_cent c_cent]=centroid1(output_image);
   total_pix=sum(sum(output_image));
   disp('Total Pixel=');
   disp(total_pix);

    if (total_pix>8000)
            disp('back()');
           fprintf(s,'b');
    else 
        if (c_cent<150)
            disp('left()');
            fprintf(s,'l');
        elseif (c_cent>170)
            disp('right()');
            fprintf(s,'r');
        else
            disp('forward()');
            fprintf(s,'f');
        end
    end
end            
