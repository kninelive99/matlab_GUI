close all; clear; clc;

logo1 = imread('EWaC-logo.jpg');
[x,map,alpha] = imread('EWaC-logo.png');

% logo = logo1;
% n = 2362;
% for i = 1:n
%     for j = 1:n
%         if logo1(i,j,1) >200 && logo1(i,j,2) >200 && logo1(i,j,3) >200
%             logo(i,j,:) = 0;
%         else
%             logo(i,j,:) = 1;
%         end
%     end
% end

%%
% figure(9)
% axes
% im = image(logo1);
% set(im,'AlphaDataMapping','direct')
% set(im,'AlphaData',logo)
% axis square
% box off
% set(gca,'visible','off')

%%
image(logo1,'AlphaData',alpha)
set(gca,'visible','off')





