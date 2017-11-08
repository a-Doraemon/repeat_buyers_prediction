# repeat_buyers_prediction
    数据来源：https://tianchi.aliyun.com/getStart/introduction.htm?spm=5176.100066.0.0.56a6e50bCtxDnw&raceId=231576  
    由于数据比较大，共1.79G（有一个文件竟然1.77G），我的电脑不论是用R还是Python都无法一次读取这么大的文件，，，最后还是用SQL处理原始数据，然后用R做分析以及建模（用了逻辑斯蒂回归，提升树，以及最近比较火的XGBoost），将最终的结果提交到官网，排名第37/1092(3.4%)。后面还要进一步的优化呀~~
