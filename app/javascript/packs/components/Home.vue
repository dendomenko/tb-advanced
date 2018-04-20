<template>
    <b-card no-body>
        <b-tabs card>
            <b-tab no-body title="Picture 1" active>
                <b-card-img bottom src="https://lorempixel.com/600/200/food/1/" />
                <b-card-footer>Picture 1 footer</b-card-footer>
            </b-tab>
            <b-tab no-body title="Picture 2">
                <b-card-img bottom src="https://lorempixel.com/600/200/food/5/" />
                <b-card-footer>Picture 2 footer</b-card-footer>
            </b-tab>
            <b-tab no-body title="Picture 3">
                <b-card-img bottom src="https://lorempixel.com/600/200/food/6/" />
                <b-card-footer>Picture 3 footer</b-card-footer>
            </b-tab>
            <b-tab title="Text">
                <h5>This tab does not have the <code>no-body</code> prop set</h5>
                Quis magna Lorem anim amet ipsum do mollit sit cillum voluptate ex nulla
                tempor. Laborum consequat non elit enim exercitation cillum aliqua consequat
                id aliqua. Esse ex consectetur mollit voluptate est in duis laboris ad sit
                ipsum anim Lorem. Incididunt veniam velit elit elit veniam Lorem aliqua quis
                ullamco deserunt sit enim elit aliqua esse irure.
            </b-tab>
        </b-tabs>
    </b-card>
</template>