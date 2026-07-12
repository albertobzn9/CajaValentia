function cmc_ocultar_controles_legacy(handles)
%CMC_OCULTAR_CONTROLES_LEGACY Oculta opciones retiradas sin cambiar el .fig.

tags = {'checkbox2', 'checkbox5', 'checkbox6', 'checkbox9', 'checkbox10', ...
    'checkbox11', 'checkbox12', 'edit2', 'text2', 'edit10', 'edit11', ...
    'edit12', 'edit13', 'text9', 'text11', 'text12', 'text13'};

for i = 1:numel(tags)
    if isfield(handles, tags{i})
        set(handles.(tags{i}), 'Visible', 'off');
    end
end
