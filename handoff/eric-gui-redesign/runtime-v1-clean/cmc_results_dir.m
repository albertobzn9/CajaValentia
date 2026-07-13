function resultsDir = cmc_results_dir
%CMC_RESULTS_DIR Carpeta local para guardar/cargar resultados.

resultsDir = fullfile(cmc_root(), 'resultados');
if exist(resultsDir, 'dir') ~= 7
    mkdir(resultsDir);
end
