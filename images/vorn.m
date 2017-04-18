hold on;
voronoi([centroidS(:, 1); centroidT(:, 1); centroidV(:, 1);], [centroidS(:, 2); centroidT(:, 2); centroidV(:, 2);]);

axis([2.29 2.39 2.26 2.36]);
xlabel('Feature 1');
ylabel('Feature 2');