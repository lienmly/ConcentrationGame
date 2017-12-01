## Game Quick Look
<table>
    <tbody>
        <tr>
            <th>
                Screen Shots
            </th>
            <th>
                Note
            </th>
        </tr>
        <tr>
            <td>
                <img src="https://github.com/lienmly/ConcentrationGame/blob/master/GameScreenShots/animalTheme.png" height="350" >
            </td>
            <td>
                <ul>
                    <li>Animal Theme</li>
                    <li>I found the matching quite fast, so the score I got was really high.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
                <img src="https://github.com/lienmly/ConcentrationGame/blob/master/GameScreenShots/flagTheme.png"  height="350" >
            </td>
            <td>
                Flag theme
            </td>
        </tr>
        <tr>
            <td><img src="https://github.com/lienmly/ConcentrationGame/blob/master/GameScreenShots/flagThemeNoneSelected.png"  height="350" ></td>
            <td>Flag theme. No card is selected yet.</td>
        </tr>
        <tr>
            <td><img src="https://github.com/lienmly/ConcentrationGame/blob/master/GameScreenShots/symbolTheme.png"  height="350" ></td>
            <td>Symbol Theme</td>
        </tr>
        <tr>
            <td><img src="https://github.com/lienmly/ConcentrationGame/blob/master/GameScreenShots/foodTheme.png"  height="350" ></td>
            <td>Food Theme</td>
        </tr>
        <tr>
            <td><img src="https://github.com/lienmly/ConcentrationGame/blob/master/GameScreenShots/haloweenTheme.png"  height="350" ></td>
            <td>Haloween Theme</td>
        </tr>
        <tr>
            <td><img src="https://github.com/lienmly/ConcentrationGame/blob/master/GameScreenShots/sportTheme.png"  height="350" ></td>
            <td>Sport theme</td>
        </tr>
        <tr>
            <td><img src="https://github.com/lienmly/ConcentrationGame/blob/master/GameScreenShots/landscape.png"  height="150" ></td>
            <td>Landscape mode</td>
        </tr>
    </tbody>
</table>

## Game's Rules
* If you find 02 matching cards, your score will increase by 2 as the base score. The faster you find a matching pair, the higher the score will be; and of course the slower you find matching pairs, the score will still be added, but the score added will be lower.
* If you find 02 non-matching cards, your score will decrease by 1 for each card already previously seen at least once.
* **New Game** button can be clicked anytime during the game. Game will be refreshed to a new theme.
* New theme can be added in ViewController.swift using `func addTheme(name themeName: String, with themeArray: [String], color themeColor: [(Double, Double, Double, Double)])` from Concentration.swift
