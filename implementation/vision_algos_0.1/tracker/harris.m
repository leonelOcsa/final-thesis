function [ha,patch_coords, patches] = harris(I, brd_width, thresh)

%function [ha,patch_coords, patches] = harris(I, brd_width, thresh)
%
%harris corner detector. 
%Detects corners in image grayscale image I (a matrix)
%brd_width indicates the size of the correlation window, such that
%corellation window width = 2*brd_width + 1
%ha: harris corner response function (somewhat modified by Niels Christian
%Overgaard)
%patch_coords: nx2 matrix containing corner coordinates
%patches: neighnourhoods of the corners in patch_coords.


[m,n] = size(I);
FI = fft2(I);

wx = ones(m,1)*(-n/2:n/2-1)/n;
wy = (-m/2:m/2-1)'*ones(1,n)/n;

gbellx = exp(-(wx/.5).^2);
gbelly = exp(-(wy/.5).^2);
gbell = exp(-((wy.^2+wx.^2)/.5^2));

clear i;
gradx = real(ifft2(fftshift(i*wx).^1.*FI.*fftshift(gbellx)));
grady = real(ifft2(fftshift(i*wy).^1.*FI.*fftshift(gbelly)));

IxIx = gradx.*gradx;
IyIy = grady.*grady;
IxIy = gradx.*grady;

gbell2 = exp(-((wy.^2+wx.^2)/(.15)^2));
IxIxg = abs(ifft2(fftshift(fft2(IxIx)).*(gbell2)));
IyIyg = abs(ifft2(fftshift(fft2(IyIy)).*(gbell2)));
IxIyg = abs(ifft2(fftshift(fft2(IxIy)).*(gbell2)));

deti = IxIxg.*IyIyg-IxIyg.*IxIyg;
tr = IxIxg+IyIyg;

#nc's responsfunktion:
level=mean(mean(IxIxg+IyIyg)).^2;
ha = 4*(deti)./(level+tr.^2);
#imagesc(ha,1)
#imagesc(log(abs(ha)+1),1);


[m n]=size(ha);
harriscorners=zeros(m,n);
C1=ha(1:m-2,1:n-2);
C2=ha(2:m-1,1:n-2);
C3=ha(3:m,1:n-2);
C4=ha(1:m-2,2:n-1);
C5=ha(2:m-1,2:n-1);
C6=ha(3:m,2:n-1);
C7=ha(1:m-2,3:n);
C8=ha(2:m-1,3:n);
C9=ha(3:m,3:n);
E=max(C9,max(C8,max(C7,max(C6,max(C5,max(C4,max(C3,max(C1,C2))))))));
harriscorners(2:m-1,2:n-1)=(E==C5(:,:)).*(E>thresh);

%borders of harriscorners needs to be zero
harriscorners(1:brd_width, :) = 0;
harriscorners(end-brd_width:end, :) = 0;
harriscorners(:, 1:brd_width) = 0;
harriscorners(:, end-brd_width:end) = 0;


patch_coords = zeros(sum(harriscorners(:)),2);
k = 1;
for i = 1:m
  for j = 1:n
   if harriscorners(i,j)>0,
     patch_coords(k,:) = [i,j];
     k = k + 1;
   end
  end
end


#keyboard
patches = cell(size(patch_coords,1),1);
for i = 1:length(patches),
  patches{i} = I(patch_coords(i,1)-brd_width:patch_coords(i,1)+brd_width,patch_coords(i,2)-brd_width:patch_coords(i,2)+brd_width);
end
