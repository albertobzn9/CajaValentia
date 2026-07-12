function rootDir = cmc_setup_paths
%CMC_SETUP_PATHS Prepara rutas desde la carpeta autocontenida desplegada.

rootDir = cmc_root();
addpath(rootDir);
addpath(fullfile(rootDir, 'Valentia'));
addpath(fullfile(rootDir, 'Valentia', 'valentia'));
cmc_results_dir();
