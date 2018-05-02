<template>
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <b-form @submit="onSubmit"
                    @reset="onReset" @keyup="validatePassword"
                    v-if="show">
                <b-form-group label="Email address:"
                              label-for="exampleInput1">
                    <b-form-input id="exampleInput1"
                                  type="email"
                                  v-model="form.email"
                                  required
                                  placeholder="Enter email">
                    </b-form-input>
                </b-form-group>
                <b-form-group label="Your Password:"
                              label-for="password">
                    <b-form-input id="password"
                                  type="password"
                                  v-model="form.password"
                                  required
                                  placeholder="Enter password">
                    </b-form-input>
                </b-form-group>
                <b-form-group label="Password Confirmation:"
                              label-for="password-confirmation">
                    <b-form-input id="password-confirmation"
                                  type="password"
                                  v-model="form.passwordConfirmation"
                                  required
                                  placeholder="Enter password">
                    </b-form-input>
                </b-form-group>
                <b-alert show variant="danger" v-if="invalidPassword">Passwords are not match</b-alert>
                <b-button type="submit" variant="primary">Sign Up</b-button>
                <b-button type="reset" variant="danger">Reset</b-button>
            </b-form>
        </div>
        <div class="col-md-4"></div>
    </div>
</template>

<script>
  import {mapActions} from 'vuex';
  import {mapGetters} from 'vuex';

  export default {
    data() {
      return {
        form: {
          email: '',
          password: '',
          passwordConfirmation: ''
        },
        invalidPassword: false,
        show: true
      }
    },
    computed: {
      ...mapGetters({
        isLogged: 'authentication/isLogged'
      })
    },
    methods: {
      ...mapActions({
        signUp: "authentication/signUp",
      }),
      onSubmit(e) {
        e.preventDefault();
        this.signUp(this.form)
          .then(() => {
            if (this.isLogged) {
              this.$router.push('/');
            }
          });
      },
      onReset(e) {
        e.preventDefault();
        this.form.email = '';
        this.form.password = '';
        this.form.passwordConfirmation = '';
        /* Trick to reset/clear native browser form validation state */
        this.show = false;
        this.$nextTick(() => {
          this.show = true
        });
      },
      validatePassword(e) {
        // e.preventDefault();
        if (e.target.id === 'password-confirmation' || e.target.id === 'password') {
          this.invalidPassword = this.form.password !== this.form.passwordConfirmation;
        }
      }
    }
  }
</script>