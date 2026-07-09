function Info = cmc_modern_preflight
%CMC_MODERN_PREFLIGHT Detecta y configura la USB-6501 sin escribir salidas.

cmc_setup_paths();
cmc_modern_disarm_outputs();

if exist('daq','file') ~= 2
    error('CMC:DAQToolbox', ...
        'Instale Data Acquisition Toolbox y el soporte NI-DAQmx antes de esta prueba.');
end

Devices = daqlist('ni');
Ids = cellstr(Devices.DeviceID);
Models = cellstr(Devices.Model);
Index = find(strcmp(Models,'USB-6501'),1);
if isempty(Index)
    error('CMC:NI6501NotFound','No se encontro una NI USB-6501.');
end

DeviceID = Ids{Index};
IO = CMCNI6501(DeviceID); %#ok<NASGU>
Info = struct('DeviceID',DeviceID,'Model',Models{Index}, ...
    'InputLines','port0/line0:7','OutputLines','port1/line0:7, port2/line0:7');
fprintf('OK preflight: %s (%s). No se escribio ninguna salida.\n', ...
    Info.DeviceID,Info.Model);
