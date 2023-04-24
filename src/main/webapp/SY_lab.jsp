<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<!DOCTYPE html>
<html>
  <head>
    <title>Vue Shopping Cart</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  </head>
  <body>
  
<form method="post" action="${path }/mailSend.do">
<label>receiver<input class="form-control" name="receiver" type="email" required="required"></label>
<label>sender<input class="form-control" name="sender" type="email" required></label>
<div><label>title</label><input class="form-control" name="title" required></div>
<div><label>content</label></div>
<textarea class="form-control" name="content" cols="100" required></textarea>
<br>
<button class="btn btn-secondary">메일보내기</button>
</form>

    <div id="app">
      <h1>Vue Shopping Cart</h1>
      <form>
        <select v-model="selectedItem">
          <option disabled value="">Please select an item</option>
          <option v-for="item in items" :value="item">{{ item.name }} - {{ item.price }}</option>
        </select>
        <label>Amount:</label>
        <input type="number" v-model.number="selectedAmount" min="1" max="10">
        <button @click="addItemToCart" :disabled="!selectedItem || selectedAmount <= 0">Add to Cart</button>
        <h2>Cart</h2>
        <ul>
          <li v-for="(item, index) in cart" :key="index">
            {{ item.name }} - {{ item.price }} x {{ item.amount }}
            <input :name="'name[' + index + ']'" :value="item.name">
          </li>
        </ul>
        <button type="submit" :disabled="cart.length === 0">Submit</button>
      </form>
    </div>




    <script>
      var app = new Vue({
        el: '#app',
        data: {
          items: [
            { name: 'Item A', price: '$10.00' },
            { name: 'Item B', price: '$15.00' },
            { name: 'Item C', price: '$20.00' },
          ],
          selectedItem: null,
          selectedAmount: 1,
          cart: []
        },
        methods: {
          addItemToCart: function() {
            var newItem = Object.assign({}, this.selectedItem);
            newItem.amount = this.selectedAmount;
            var existingItem = this.cart.find(item => item.name === newItem.name && item.price === newItem.price);
            if (existingItem) {
              existingItem.amount += newItem.amount;
            } else {
              this.cart.push(newItem);
            }
            this.selectedItem = null;
            this.selectedAmount = 1;
          },
          submitCart: function() {
            // Here you can do whatever you need to do with the cart data, such as sending it to a server
            console.log(this.cart);
            // Clear the cart and any selected items
            this.cart = [];
            this.selectedItem = null;
            this.selectedAmount = 1;
          }
        }
      })
    </script>
  </body>
</html>

