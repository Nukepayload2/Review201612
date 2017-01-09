## 说明
以$开头，以$结尾的部分是代码段中需要替换的部分。
## 继承
### 定义继承帮助方法
``` js
var __extends = (this && this.__extends) || function (self, _super) {
    for (var prop in _super) 
        if (super.hasOwnProperty(prop))
            self[prop] = _super[prop];
    function newPrototype() {
        this.constructor = self; 
    }
    self.prototype = _super === null ? Object.create(_super) : (newPrototype.prototype = _super.prototype, new newPrototype());
};
```
### 使用继承
```js
var $类名$ = (function (_super) {
    __extends($类名$, _super);
    // 构造函数
    function $类名$() {
        // 调用没参数的构造函数
        return _super.apply(this, arguments) || this; 
        // 如果有参数：
        return _super.call(this, $参数$, ...) || this;
    }
    return $类名$;
}($基类名$));
```
## 属性
```js
Object.defineProperty($类名$.prototype, "$属性名$", {
    get: function () {
        // TODO: 编写属性的 get 。
    },
    set: function (value) {
        // TODO: 编写属性的 set 。
    },
    enumerable: true,
    configurable: true
});
```
## 静态方法
```js
$类名$.$方法名$ = function () { };
```
## 实例方法
```js
$类名$.prototype.$方法名$ = function () { };
```
## 类和构造函数
```js
var $类名$ = (function () {
    function $类名$() {
        // TODO: 初始化 $类名$ 。
    }
    return $类名$;
    // 如果类是公有的就写下一行的代码
    $上级命名空间$.$类名$ = $类名$
}());
```
## 命名空间
```js
var $命名空间$;
(function ($命名空间$) {

})($命名空间$ || ($命名空间$ = {}));
```
## 导入
```js
var $别名$ = $命名空间或类名$;
```
## 覆盖方法
```js
$类名$.prototype.$方法名$ = function ($参数$) {
    var result = _super.prototype.$方法名$.call(this, $参数$);
};
```