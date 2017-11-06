getChar(Input) :- get_char(_Input),
                  get_char(Input).


getCode(Input) :- get_code(_TempInput),
                  get_code(TempInput),
                  Input is TempInput - 48.
