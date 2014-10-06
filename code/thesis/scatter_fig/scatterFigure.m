function f = scatterFigure(d,m,varargin)

p = inputParser();
p.addParamValue('exampleTrodes',defaultExampleTrodes(d,m));
p.parse(varargin{:});
opt = p.Results;

end

function t = defaultExampleFields(d,m)
    if(strContains(m.pFileName,'caillou'))
        t = [1,2];
    else
        error('scatterFigure:noNameMatch',['No default trodes for ', m.pFileName]);
    end

end

function b = strContains(s,target)

    b = ~isempty(regexp(s,target,'ONCE'));

end