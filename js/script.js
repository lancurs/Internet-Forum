/**
 * Created by yangpeng on 15-5-7.
 */
function test() {
    var ss = document.getElementById("tst").value;
    var title = document.getElementById("title").value;
    if (ss.length < 5) {
        alert("The message you have entered is too short.");
        return false;
    } else if (title.length < 5) {
        alert("The title you have entered is too short");
        return false;
    }
    else if(title.length>80)
    {
        alert("The title you have enterd is too long")
    }
    else {
        return true;
    }
}