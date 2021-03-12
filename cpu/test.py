import numpy as np
import tensorflow as tf
def main(args):
# 生成数据集
    x = np.linspace(-1,1,100)
    y = x**2+np.random.randn(100)*0.05
# 定义网络架构
    model = tf.keras.Sequential([
    tf.keras.layers.Dense(64,input_shape=(1,),activation="relu"),
    tf.keras.layers.Dense(32,input_shape=(1,),activation="relu"),
    tf.keras.layers.Dense(16,input_shape=(1,),activation="relu"),
    tf.keras.layers.Dense(1)])
#设置训练参数
    model.compile(
    loss=tf.keras.losses.Huber(),
    optimizer="adam",
    metrics=["mse"])
#训练并查看训练进度
    history = model.fit(x,y,epochs=10,batch_size = 72,verbose=0)
    name = args.get("name", "stranger")
    greeting = "Hello " + name + "!"
    print(greeting)
    return {"greeting": greeting}
