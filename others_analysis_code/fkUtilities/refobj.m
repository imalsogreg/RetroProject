classdef refobj < dynamicprops
%REFOBJ reference structure object
%
%  A refobj functions like a reference to scalar struct
%

    methods
        
        function obj = refobj(varargin)
           
            if nargin==1 && isstruct(varargin{1})
                if ~isscalar(varargin{1})
                    error('refobj:refobj:invalidArgument', 'Only scalar structs allowed')
                end
                s = varargin{1};
            else
                s = struct( varargin{:} );
            end
            
            fn = fieldnames(s);
            val = struct2cell(s);
            
            for k=1:numel(fn)
                obj.addprop( fn{k} );
                obj.(fn{k}) = val{k};
            end
                    
            
        end
        
        function display(obj)
           
            w = warning('off', 'MATLAB:structOnObject');
            disp( 'Reference object with fields:' )
            disp( struct(obj) )
            warning(w);
            
        end
        
        function b=isfield(obj,f)
            b = ismember( f, properties(obj) );
        end
        function b=isstruct(obj)
            b = true;
        end
            
        function obj = subsasgn( obj, s, val )
           
            propadded = false;
            
            if strcmp( s(1).type, '.' )
                if isempty(findprop( obj, s(1).subs ))
                    p = obj.addprop( s(1).subs );
                    propadded=true;
                end
            else
                error('refobj:subsasgn', 'Invalid indexing. Only scalar reference objects allowed')
            end
            
            try
                obj = builtin( 'subsasgn', obj, s, val );
            catch me
                if propadded
                    delete(p);
                end
                rethrow(me)
            end
            
        end
        
        function rmfield(obj,p)
           
            p = findprop( obj, p );
            delete(p)
            
        end
        
        function obj = horzcat(obj,varargin)
           error('refobj:invalidOperation', 'Concatenation not allowed for refobj') 
        end
        function obj = vertcat(obj,varargin)
           error('refobj:invalidOperation', 'Concatenation not allowed for refobj') 
        end
        function obj = cat(obj,varargin)
           error('refobj:invalidOperation', 'Concatenation not allowed for refobj') 
        end
        
    end
    
end