# HouseHunter

A Telegram Bot, built with Vapor, for crawling house renting websites.

    House hunting isn't that fun, or easy. 
    Making it a Telegram bot help me and my SO keep a close attention to recent listings, discuss and share possible rentals.

## Pre-requisites

1. Install [Vapor](https://docs.vapor.codes/3.0/install/macos/)
2. Create your own Bot:
    - In Telegram, open a conversation with BotFather
    - Get it running with `/start`
    - Create a new bot with `/newbot`. Give its details
    - Save the API Token

## Roll your own

- Clone or download this repository
- Run `vapor fetch` or `swift package resolve`
- Run `vapor xcode -y` to generate an .xcodeproj and open it.

### Update your details

- Create a file `.env` in the root folder of the project with your credentials:

```
TOKEN=<api_token>
CHAT_ID=<chat_id>
```

Get your previously saved API Token and replace`<api_token>`.

You can get the `<chat_id>` from adding your bot to your group or private chat.

### Update the current Providers

Under the [Providers](Sources/App/Crawler/Providers/) folder you'll find the two supported providers, Idealista and Imovirtual.

These are the biggest in my current country but you can add more easily since they are nothing more than dumb parsers of the HTML to House objects, by using Xpath.

For adjusting to your search you can modify the `searchURL` of each Provider to your custom search. (You can do this easily by picking your variables in the actual providers site and paste the result URL)

## Deploying

I've tried deploying this to a Heroku machine. 

It's is possible but at the free layer of Heroku, after a few minutes with no activity it will idle your machine.

Since we're relying on a recurrent operation and the machine is deactivated, it won't be possible to run the Bot *as is*.

**Possible workaround:** This isn't advised by Heroku but you can have another service pinging your Bot to keep it alive 🤷🏻‍♂️

## Final Notes

    We found a house!
    I won't be adding new features to this (although I had in progress MongoDB support)
    Feel free to Contribute back to the project if you find it useful and have something to add on.
    Or just fork it 👍🏻

