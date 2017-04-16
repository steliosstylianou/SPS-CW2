centroidS = mean(trainfeat(1:10,:));
centroidT = mean(trainfeat(11:20,:));
centroidV  = mean(trainfeat(21:30,:));

voronoi([centroidS(:, 1); centroidT(:, 1); centroidV(:, 1);], [centroidS(:, 2); centroidT(:, 2); centroidV(:, 2);]);
xlim([min(trainfeat(:,1)), max(trainfeat(:,1)) ]);
ylim([min(trainfeat(:,2)), max(trainfeat(:,2))]);