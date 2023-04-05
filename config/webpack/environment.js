const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        Popper: ['popper.js', 'default'],
        dayjs: 'dayjs/dayjs.min'
    })
)
environment.config.merge(
    module.exports = {
        resolve: {
            alias: {
                jquery: 'jquery/src/jquery',
            }
        }
    }
)

module.exports = environment
