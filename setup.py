import setuptools

setuptools.setup(
    name="lakeprof",
    packages=["."],
    entry_points='''
        [console_scripts]
        lakeprof=lakeprof:lakeprof
    '''
)
