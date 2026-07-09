classdef CMCAudio < handle
    %CMCAUDIO Stereo playback adapter replacing legacy winsound output.

    properties (SetAccess = private)
        SampleRate
        Player
    end

    methods
        function obj = CMCAudio(SampleRate)
            if nargin < 1
                SampleRate = 20000;
            end
            obj.SampleRate = SampleRate;
            obj.Player = [];
        end

        function playSamples(obj,Samples)
            obj.stop();
            obj.Player = audioplayer(Samples,obj.SampleRate);
            play(obj.Player);
        end

        function stop(obj)
            if ~isempty(obj.Player) && isvalid(obj.Player)
                stop(obj.Player);
            end
        end
    end
end
