function [ln, h, p, t, a1, a2, a3, a4, a_rh, rh_bef, rh_aft, cirrus, wat_drop, ice_part] = read_data_with_header(filename)

    % Open the file for reading
    fileID = fopen(filename, 'r');
    if fileID == -1
        error('Error opening the file.');
    end

    % Initialize variables to store data in cell arrays
    ln = {};
    h = {};
    p = {};
    t = {};
    a1 = {};
    a2 = {};
    a3 = {};
    a4 = {};
    a_rh = {};
    rh_bef = {};
    rh_aft = {};
    cirrus = {};
    wat_drop = {};
    ice_part = {};

    % Find the line with 'RH' (header line)
    while ~feof(fileID)
        current_line = fgetl(fileID);
        if contains(current_line, 'RH')
            break;
        end
    end

    % Read the header line and skip the units line
    header = split(strtrim(current_line), ' ');
    units_line = fgetl(fileID); % Skip the units line

    % Read the data below the header line
    while ~feof(fileID)
        current_line = fgetl(fileID);
        if isempty(current_line)
            break; % Stop when an empty line is encountered
        end
        values = sscanf(current_line, '%f');
        ln = [ln, values(1)];
        h = [h, values(2)];
        p = [p, values(3)];
        t = [t, values(4)];
        a1 = [a1, values(5)];
        a2 = [a2, values(6)];
        a3 = [a3, values(7)];
        a4 = [a4, values(8)];
        a_rh = [a_rh, values(9)];
        rh_bef = [rh_bef, values(10)];
        rh_aft = [rh_aft, values(11)];
        cirrus = [cirrus, values(12)];
        wat_drop = [wat_drop, values(13)];
        ice_part = [ice_part, values(14)];
    end

    % Convert cell arrays to arrays of doubles
    ln = cell2mat(ln);
    h = cell2mat(h);
    p = cell2mat(p);
    t = cell2mat(t);
    a1 = cell2mat(a1);
    a2 = cell2mat(a2);
    a3 = cell2mat(a3);
    a4 = cell2mat(a4);
    a_rh = cell2mat(a_rh);
    rh_bef = cell2mat(rh_bef);
    rh_aft = cell2mat(rh_aft);
    cirrus = cell2mat(cirrus);
    wat_drop = cell2mat(wat_drop);
    ice_part = cell2mat(ice_part);

    % Close the file
    fclose(fileID);
end
