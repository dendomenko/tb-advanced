<template>
  <div id="app">
      <app-header></app-header>
      <app-error-bar></app-error-bar>
      <router-view></router-view>
  </div>
</template>

<script>
  import Header from "./components/Header";
  import ErrorBar from "./components/ErrorBar";

  export default {
    components: {
      appHeader: Header,
      appErrorBar: ErrorBar
    }
  }
</script>

<style>

</style>
