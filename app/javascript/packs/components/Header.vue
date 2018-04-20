<template>
    <b-navbar toggleable="md" type="dark" variant="dark">

        <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>

        <b-navbar-brand href="#">
            <img src="/images/home.png" alt="rss feed" style="height: 46px"/>
        </b-navbar-brand>

        <b-collapse is-nav id="nav_collapse">

            <b-navbar-nav>
                <b-nav-item href="#">Link</b-nav-item>
                <b-nav-item href="#" disabled>Disabled</b-nav-item>
            </b-navbar-nav>

            <b-nav-form>
                <b-form-input size="sm" class="mr-sm-2" type="text" placeholder="Search"/>
                <b-button size="sm" class="my-2 my-sm-0" type="submit">Search</b-button>
            </b-nav-form>

            <!-- Right aligned nav items -->
            <b-navbar-nav class="ml-auto">
                <div v-if="isLogged">
                    <b-nav-item-dropdown right>
                        <!-- Using button-content slot -->
                        <template slot="button-content">
                            <em>User</em>
                        </template>
                        <b-dropdown-item href="#">Profile</b-dropdown-item>
                        <b-dropdown-item href="#" @click.prevent="signOut">Signout</b-dropdown-item>
                    </b-nav-item-dropdown>
                </div>
                <div v-else>
                    <b-navbar-nav>
                        <router-link to="/user/signin" tag="li" class="btn btn-md btn-outline-success">SignIn</router-link>
                        <router-link to="/user/signup" tag="li" class="btn btn-md btn-outline-primary">SignUp</router-link>
                    </b-navbar-nav>
                </div>
            </b-navbar-nav>

        </b-collapse>
    </b-navbar>
</template>

<script>
    import { mapActions } from 'vuex';

    export default {
        computed: {
            isLogged() {
                return this.$store.getters.isLogged;
            }
        },
        methods: {
            ...mapActions({
                signOut: "signOut"
            })
        }
    }
</script>