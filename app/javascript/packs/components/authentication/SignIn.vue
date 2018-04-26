<template>
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <b-form @submit="onSubmit" @reset="onReset" v-if="show">
                <b-form-group label="Email address:"
                              label-for="email">
                    <b-form-input id="email"
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
                <b-button type="submit" variant="primary">Sign In</b-button>
                <b-button type="reset" variant="danger">Reset</b-button>
            </b-form>
        </div>
        <div class="col-md-4"></div>
    </div>
</template>

<script>
    import { mapActions } from 'vuex'

    export default {
        data() {
            return {
                form: {
                    email: '',
                    password: '',
                },
                show: true
            }
        },
        methods: {
            ...mapActions({
                signIn: "signIn",
            }),
            onSubmit(evt) {
                evt.preventDefault();
                this.signIn(this.form).then(response => console.log(response));
            },
            onReset(evt) {
                evt.preventDefault();
                /* Reset our form values */
                this.form.email = '';
                this.form.password = '';
                /* Trick to reset/clear native browser form validation state */
                this.show = false;
                this.$nextTick(() => {
                    this.show = true
                });
            }
        }
    }
</script>