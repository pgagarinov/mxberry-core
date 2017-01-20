function results=run_tests(varargin)
resList{5}=mlunitext.test.run_tests();
resList{4}=mxberry.gui.test.run_tests();
resList{3}=mxberry.test.run_public_tests();
resList{2}=mxberry.pcalcalt.test.run_tests(varargin{:});
resList{1}=mxberry.db.inmem.test.run_tests(varargin{:});
results=[resList{:}];