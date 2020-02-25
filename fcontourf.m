function [] = fcontourf(img,lvls,axs)
%make a fancy (ish) contour plot without needing to specify as many options
%inputs:
% - img to plot
% - number of contourf lvls (optional, default 100)
% - caxis limits (optional, default based on data)
%  AKL, 02/21/20

if nargin < 2
    lvls = 100;
end

figure
contourf(img,lvls,'linestyle','none')
colorbar
axis image
colormap(cmrMap)

if nargin == 3
    caxis([axs(1),axs(2)])
end

