classdef CMCAudio < handle
    %CMCAUDIO DirectSound adapter replacing legacy winsound output.

    properties (SetAccess = private)
        SampleRate
        DAQ
        DeviceID
    end

    methods
        function obj = CMCAudio(SampleRate)
            if nargin < 1
                SampleRate = 20000;
            end
            if exist('daq','file') ~= 2
                error('CMC:DAQToolbox', ...
                    ['Data Acquisition Toolbox and Windows Sound Cards support ' ...
                    'are required for modern audio.']);
            end

            obj.SampleRate = SampleRate;
            Devices = daqlist;
            DeviceIDs = cellstr(Devices.DeviceID);

            for k = 1:length(DeviceIDs)
                Candidate = daq('directsound');
                try
                    addoutput(Candidate,DeviceIDs{k},1:2,'Audio');
                    Candidate.Rate = SampleRate;
                    obj.DAQ = Candidate;
                    obj.DeviceID = DeviceIDs{k};
                    return
                catch
                end
            end

            error('CMC:StereoAudioNotFound', ...
                'No DirectSound device with two output channels was found.');
        end

        function playSamples(obj,Samples)
            obj.stop();
            flush(obj.DAQ);
            preload(obj.DAQ,Samples);
            start(obj.DAQ,'NumScans',size(Samples,1));
        end

        function stop(obj)
            if ~isempty(obj.DAQ)
                try
                    stop(obj.DAQ);
                    flush(obj.DAQ);
                catch
                end
            end
        end
    end
end
