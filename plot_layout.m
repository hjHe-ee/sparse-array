function plot_layout(pos, ttl)
    pos = sort(pos(:).');
    y = zeros(size(pos));
    stem(pos, y, 'filled','LineWidth',1.1); hold on;
    plot([min(pos) max(pos)],[0 0],'-','LineWidth',0.8);
    hold off;
    grid on;
    xlabel('Position'); yticks([]);
    title(sprintf('%s\nN = %d, Aperture = %.3g', ttl, numel(pos), max(pos)-min(pos)));
    xlim([min(pos)-0.5, max(pos)+0.5]);
end