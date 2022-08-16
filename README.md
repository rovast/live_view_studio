# LiveViewStudio

https://pragmaticstudio.com/courses/phoenix-liveview 教程示例代码。

## Preview

你可以在 issue 中快速预览相关示例(label: demo)

[Click here to view demos](https://github.com/rovast/live_view_studio/issues?q=label%3Ademo+)

## Start

1. Install dependencies with `mix deps.get`
1. Create your database with `mix ecto.setup`
1. Migrate your database with `mix ecto.migrate`
1. Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## websocket 参数含义

![Untitled](https://user-images.githubusercontent.com/9459488/184611644-42e7840c-f38a-4337-9a3d-3762cc711c27.png)

live view 里面的 参数个数，和 live view 的 `<%= %>` 绑定的参数是一一对应的。有几个绑定的值，就会有几个参数。

每次更新时，就是更新了绑定的参数的值。

其中 s 表示 static 意思，就是 static html，它切分的段数，也是和绑定的参数有关系的。

![Untitled](https://user-images.githubusercontent.com/9459488/184611654-5275c2a6-5f72-4989-86bb-0e3556364926.png)

最外层的对应静态文件是 `<main>`，其中两个参数对应的是 flash message，就是两个框

![Untitled](https://user-images.githubusercontent.com/9459488/184611670-6f2f3807-f415-4529-8069-e3f1845198d5.png)

总结下来的规律就是：

- `object.s` 指的是静态 html
- `object.[0,1,2]` 对应 html 中绑定的变量
- 每次的 diff，其实就是在更新对应的参数，可以是变量，可以是 static(maybe)

