function stateDir = cmc_state_dir
%CMC_STATE_DIR Carpeta donde viven funciones auxiliares y .mat de estado.

stateDir = fullfile(cmc_root(), 'Valentia');
if exist(stateDir, 'dir') ~= 7
    error('No se encontro la carpeta de estado: %s', stateDir);
end
