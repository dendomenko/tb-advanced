import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm'
import Voting from '../components/voting'
import axios from 'axios'

Vue.use(axios);
Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
    const app = new Vue({
        el: '#question',
        components: { Voting }
    })
});
