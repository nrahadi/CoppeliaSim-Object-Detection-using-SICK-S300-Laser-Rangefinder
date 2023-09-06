sim=remApi('remoteApi');
sim.simxFinish(-1);

clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID>-1)
    disp('Connected to remote API server');
    
    % Object Handle
    [returnCode,sensor1] = sim.simxGetObjectHandle(clientID,'SICK_S300_sensor1',sim.simx_opmode_blocking);
    [returnCode,sensor2] = sim.simxGetObjectHandle(clientID,'SICK_S300_sensor2',sim.simx_opmode_blocking);
    
    % Object Command
    [returnCode,resolution,image1] = sim.simxGetVisionSensorImage2(clientID,sensor1,0,sim.simx_opmode_streaming);
    [returnCode,resolution,image2] = sim.simxGetVisionSensorImage2(clientID,sensor2,0,sim.simx_opmode_streaming);
    
    for i=1:10
        [returnCode,resolution,image1] = sim.simxGetVisionSensorImage2(clientID,sensor1,0,sim.simx_opmode_buffer);
        [returnCode,resolution,image2] = sim.simxGetVisionSensorImage2(clientID,sensor2,0,sim.simx_opmode_buffer);
        figure(1)
        imshow(image1)
        figure(2)
        imshow(image2)
        pause(0.1);
    end

    sim.simxFinish(-1);
end

sim.delete();
disp('Program ended');