classdef CMCNI6501 < handle
    %CMCNI6501 Modern, guarded adapter for the NI USB-6501.

    properties (SetAccess = private)
        DAQ
        DeviceID
        OutputState
    end

    methods
        function obj = CMCNI6501(DeviceID)
            if nargin < 1
                DeviceID = 'Dev2';
            end

            if exist('daq','file') ~= 2
                error('CMC:DAQToolbox', ...
                    ['Data Acquisition Toolbox is required. Install it and the ' ...
                    'NI-DAQmx support package before using this version.']);
            end

            Devices = daqlist('ni');
            Ids = cellstr(Devices.DeviceID);
            Index = find(strcmp(Ids,DeviceID),1);
            if isempty(Index)
                error('CMC:NI6501NotFound', ...
                    'NI device %s was not found. Run cmc_modern_preflight first.',DeviceID);
            end

            Models = cellstr(Devices.Model);
            if ~strcmp(Models{Index},'USB-6501')
                error('CMC:UnexpectedDevice', ...
                    'Expected USB-6501 at %s; found %s.',DeviceID,Models{Index});
            end

            obj.DeviceID = DeviceID;
            obj.DAQ = daq('ni');
            addinput(obj.DAQ,DeviceID,'port0/line0:7','Digital');
            addoutput(obj.DAQ,DeviceID,'port1/line0:7','Digital');
            addoutput(obj.DAQ,DeviceID,'port2/line0:7','Digital');
            obj.OutputState = zeros(1,16);
        end

        function Values = readInputs(obj)
            Values = read(obj.DAQ,1,'OutputFormat','Matrix');
            Values = double(Values(end,:));
        end

        function writeLines(obj,LegacyLines,Values)
            if ~cmc_modern_output_state('isarmed')
                error('CMC:OutputsDisarmed', ...
                    ['Physical outputs are disarmed. Run cmc_modern_arm_outputs ' ...
                    'only during a supervised hardware test.']);
            end

            LegacyLines = LegacyLines(:)';
            Values = Values(:)';
            if length(LegacyLines) ~= length(Values) || ...
                    any(LegacyLines < 9) || any(LegacyLines > 24) || ...
                    any((Values ~= 0) & (Values ~= 1))
                error('CMC:InvalidOutput', ...
                    'Output writes must use legacy lines 9:24 with binary values.');
            end

            obj.OutputState(LegacyLines - 8) = Values;
            write(obj.DAQ,obj.OutputState);
        end

        function stop(obj)
            try
                stop(obj.DAQ);
            catch
            end
        end
    end
end
