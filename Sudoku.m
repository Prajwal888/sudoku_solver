% Sudoku Solver by Prajwal Jena
% Sudoku Input - a

% 1x9 matrices                   * SAMPLE SUDOKU 1 * 
a1 = [0 1 4 7 8 9 3 0 6];   %   2 1 4 | 7 8 9 | 3 5 6
a2 = [7 9 5 1 6 3 8 4 2];   %   7 9 5 | 1 6 3 | 8 4 2
a3 = [8 6 3 4 2 5 9 1 0];   %   8 6 3 | 4 2 5 | 9 1 7
%    -------------------        ---------------------
a4 = [3 4 2 6 7 1 5 9 8];   %   3 4 2 | 6 7 1 | 5 9 8
a5 = [1 5 9 8 3 2 6 7 4];   %   1 5 9 | 8 3 2 | 6 7 4
a6 = [0 7 8 5 9 4 2 3 1];   %   6 7 8 | 5 9 4 | 2 3 1
%    -------------------        ---------------------
a7 = [4 3 6 2 5 7 1 8 9];   %   4 3 6 | 2 5 7 | 1 8 9
a8 = [5 2 1 9 4 8 7 6 3];   %   5 2 1 | 9 4 8 | 7 6 3
a9 = [9 8 7 3 1 6 4 0 5];   %   9 8 7 | 3 1 6 | 4 2 5

% 9x9 matrix
a = [a1 ; a2 ; a3 ; a4 ; a5 ; a6 ; a7 ; a8 ; a9];
s = a;          % s - Solved Sudoku

space = 0;      % To store number of blank spaces in matrix
k = 0;          % Flag to control main while loop
b = 0;          % Flag to check numbers
error = 0;      % Error in Input Matrix/Sudoku
% Check 3 things: row, column and 3x3 matrix.
test = 0;       % Check - store value to be checked
while ( k < 1 )             % SUDOKU Solving Algorithm 
    
    if ( b == 12 )
        if ( n == 1 )
            i = m-1;
            j = 9;
        else
            i = m;
            j = n-1;
        end
        while ( a(i,j) ~= 0 )   % if last value not 0 then update i&j
            if ( j == 1 )
                i = i-1;
                j = 9;
            else
                j = j-1;
            end
        end
        space = space - 1;
    end
    
    for i = 1:9                             % Scan Sudoku
        for j = 1:9                         % & 
            if ( a(i,j) == 0 )              % Blank space
                if ( s(i,j) == 0 )          % &
                    space = space + 1;      % Count space
                    b = 1;                  % Check value
                else
                    b = b+1;                % Check new value
                end
            else
                if ((i == 9) && (j == 9))   % Sudoku is Solved
                    k = 2;                  % Exit loop - solved
                end
                b = 11;                     % Move to next value
            end
            while ( b < 10 )
                s(i,j) = b;                 % Update value
                % -------------- C H E C K ----- S T A R T------------- %
                counti = 0;                 % Check - Column
                countj = 0;                 % Check - Row
                countij = 0;                % Check - 3x3 Matrix
                test = s(i,j);
                for m = 1:9                     % Scan Row & Column
                    if ( s(m,j) == test )       % check column 
                        counti = counti + 1;
                    end
                    if ( s(i,m) == test )       % check row
                        countj = countj + 1;
                    end
                end
                mi = (((fix((i-1)/3))+1)*3)-2;          % mi = 1/4/7
                nj = (((fix((i-1)/3))+1)*3)-2;          % nj = 1/4/7
                for m = mi : mi+2           % Scan 3x3 Matrix
                    for n = nj : nj+2       % &
                        if ( s(m,n) == test )
                            countij = countij + 1;
                        end
                    end
                end
                if ((counti == 2 ) || (countj == 2) || (countij == 2))
                    y = 0;
                elseif ((counti >= 2) || (countj >= 2) || (countij >= 2))
                    error = 1;
                    k = 2;                  % Leave loop - error
                else
                    y = 1;                  % Value Satisfies
                end
                % --------------- C H E C K ----- E N D --------------- %
                if ( y == 1)                    % Value Satisfies
                    if ((i == 9) && (j == 9))              % Sudoku is Solved
                        k = 2;              % Leave loop - solved
                    end
                    b = 11;                 % Move to next value
                else                        % Update value
                    b = b+1;                % || break while loop
                end                         % &
            end
            if ( b == 10 )
                if ( ((i&&j) || space ) == 1 )
                    error = 1;                  % ERROR
                    k = 2;                      % Leave loop - error
                end
                s(i,j) = 0;
                m = i;
                n = j;
                j = 10;                 % Leave j loop
            end
        end
        if ( b == 10 )
            b = 12;                     % Jump to previous value
        end
        if ( b == 12 )
            i = 10;                     % Leave i loop
        end
    end
end

% Output
s;              % Solved Sudoku
space;          % Number of blanks
error;          % Error in Input Matrix/Sudoku
