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
                ![alt text](http://url/to/GameScreenShots/animalTheme.png)
            </td>
        </tr>
    </tbody>
</table>

## Game's Rules
* If you find 02 matching cards, your score will increase by 2 as the base score. The faster you find a matching pair, the higher the score will be; and of course the slower you find matching pairs, the score will still be added, but the score added will be lower.
* If you find 02 non-matching cards, your score will decrease by 1 for each card already previously seen at least once.
* **New Game** button can be clicked anytime during the game. Game will be refreshed to a new theme.
* New theme can be added in ViewController.swift using `func addTheme(name themeName: String, with themeArray: [String], color themeColor: [(Double, Double, Double, Double)])` from Concentration.swift
