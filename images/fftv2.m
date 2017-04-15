function f = fftv2(imagename)
f = imread(imagename); %read in image
z = fft2(double(f)); % do fourier transform
q = fftshift(z); % puts u=0,v=0 in the centre
f = (abs(q)); % magnitude spectrum
Phaseq=angle(q); % phase spectrum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usually for viewing purposes
%imagesc(log(abs(q)+1));
%figure;
%imagesc(log(abs(q.^2)+1));
%colorbar;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%w = ifft2(ifftshift(q));
%imagesc(w);
end