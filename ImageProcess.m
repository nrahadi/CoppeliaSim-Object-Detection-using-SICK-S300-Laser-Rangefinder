% Displaying Combined Image (from 2 seperated vision sensor in SICK S-300).
image = imfuse(image2,image1,'montage');
figure(1)
imshow(image)

% Turning Image into Numerical Vector and plot it.
image_row_vector = image(:,:,2);
figure(2)
plot(image_row_vector)

% Performing Hough Transform.
[H,theta,rho] = hough(image_row_vector);

figure(3)
imshow(imadjust(rescale(H)),[],...
       'XData',theta,...
       'YData',rho,...
       'InitialMagnification','fit');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal 
hold on
colormap(gca,hot)

P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','black');