import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:EffeCA/screens/developerinfo.dart';
import 'package:EffeCA/screens/about.dart';
import 'package:EffeCA/screens/contact.dart';
import 'package:EffeCA/screens/leaderboard.dart';
import 'package:EffeCA/screens/message.dart';
import 'package:EffeCA/screens/eventscreen.dart';
import 'package:EffeCA/screens/firstscreen.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  HiddenDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = HiddenDrawerController(
      initialPage: FirstScreen(),
      items: [
        DrawerItem(
          text: Text('Home', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
          page: FirstScreen(),
        ),
        DrawerItem(
          text: Text(
            'Events',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.event, color: Colors.white),
          page: EventScreen(),
        ),
        DrawerItem(
          text: Text(
            'LeaderBoard',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.group, color: Colors.white),
          page: LeaderboardScreen(),
        ),
        DrawerItem(
          text: Text(
            'About',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.info_outline, color: Colors.white),
          page: AboutScreen(),
        ),
        DrawerItem(
          text: Text(
            'Message',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.message, color: Colors.white),
          page: MessageScreen(),
        ),
        DrawerItem(
          text: Text(
            'Developer Info',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.info, color: Colors.white),
          page: DevInfoScreen(),
        ),
        DrawerItem(
          text: Text(
            'Contact',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.call, color: Colors.white),
          page: ContactScreen(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HiddenDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Container(
                // height: 75,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 5)),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                width: MediaQuery.of(context).size.width * 0.6,
                child: ClipOval(
                  child: Image(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUTExMWFRUXGBgYFxgYGBgaGBgbGhoXGBkdGBsYHSggGB8lHRcYITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OGxAQGy0mICYtLTctMi01Ly0vLS0tLS8vLSstLS0tLy01LS0tLS0tLS0tLS0tLy0tLS0tLS0tLS0tLf/AABEIAOEA4AMBIgACEQEDEQH/xAAcAAAABwEBAAAAAAAAAAAAAAAAAgMEBQYHAQj/xABKEAABAgQEAwQHBAcGBAYDAAABAhEAAyExBBJBUQVhcQYiMoEHE5GhsdHwQlLB4RQjM1NykvEVQ2KCk9IWJCVjNHOys7TTFzWi/8QAGwEAAgMBAQEAAAAAAAAAAAAABAUCAwYBAAf/xAA6EQABAwIDBQUGBQQCAwAAAAABAAIDBBESITEFE0FRcSIyYZGhFEKBsdHwBiMzweE0coLxJFIVQ2L/2gAMAwEAAhEDEQA/AMVr7oDnneLRK4TKS3df+KsOZchKfCkDoBHHbWaO6D5rRx/hic994Hr9FU5WGmKqlCiK1aHMvhM4iwFNSItAA/ANHDA7tqzHIZJhH+GIB33k+Q+qgk8DVqsDyhdPBki6lH2M8SpV84SUr6HPlFJ2hUu98oobFoY/cv1uU0Tw+X90HS587wqEJowG9moOkCYvoSKbFzCM2cwLlhbvbC8Vl0j9SSu2gh7rQPgE4UrW2tah4KVbC2255RHq4iM1LHXMAGHIxO4PsXjJymmpMpLBQPcNCCQSlMwEuzD+sTbTm13ZBAzbYibkztHwUXOxSASCpIIYag84SmcUGYpCcwpcgfGNH4X6OsOgfrnmqqykmYgXLuyjy+iwsPD+GSZSQmUkBO5JXq7gqKmcqOhob0EevA3mfRAu2hVv7tm+pWPSMc6gMpAJNcwI93lDxcwJu1PL3GJH0pEpnpahym1DaT8zFBmqKlVcmly5gptC2UB4NgvRbelhBZIMTr5cArDP4mhP2nIpQe20KT+LgYdDJ8c2YylCwQiXbVjntukRXBhVHRta0iYw6BLTKAObuzFHkopWkjyCUnziwUtO02BuVTPteucMVsI6fVJY7Ez0u7J6FPzO8RqpqlnvL1eppHp5eHckZRQ6pSXDkUop9qEF0mIHiHYjBTFEzJaiSAWE2YFGyQwUoXKGG7u9zFcVTGw9ltvX6ICZ88vfeT8SPqsTwXBcwCivMGfuil2uecSUnAy0WTW1a/GLPxL0UzUozyJ3rFd1kJQpJNQk/tJrBmKq6bxU8YqfhlZcQgAmzLl0cJNcqi9FpPmIhM6eUdl9xy09E32dWUMJAkiwnmc/9J830I4VRFYnjKQWQM+jmghBKZ865yJsxcfmYFZSOtieQ0eKeS7XiLt3AC93Jv10+ak5uLlppML0PdoS5tozezrBMNjZ9BKQJKQ4zKDmt2CngYThctFWzHcsfZtEjMW4BYOA1KPep3Oj8o6ZY2CzMzzOnl9V5lHPMcUxDQeDdfi76WTUSCS8xapimAdRdm2Fg0LMPrlCc/EJQHUoDr+EMziFrBNZcugdXiU+20VWkkzcckSZKem7DBnyGvUn9yU79XL9YFhA9aO9QO5DMdgdfKLJ2V7OJxg9fPUZGFQr9bMfKmafuSdXehI6CtorgfDZVJk8FMjMB6tJIWsfemG6U8gcx/w6znEO2GYNkQO6ZaVF2SglwESh3RoKB6C7RcMLbYsylUu+nBEQDWnvOGV+ml+vkFWoAgHfT4Q0m8SlD7Y8nJ90Ctje7uglP5aiKIXe4DqU7jivyiIm8dT9lKj1tDKdxiYbMnoPnBkezp3C9rdUqn2/Rx5B2Lop1SvobCGU7HI+8N9jS0QU2epV1EwrgMEqatMtAzKUWSHSConQOQ3WCf8Ax+DvlI5/xA5+UbfNPF8QDhq6l2p5mLB2f7EzsS65ivUpYKSogLCn0ARMGVgXdTbXi2dlew0uQUTJhzrACwwUkSyR4T32WxBqxFjYxcggW2ahegJbe1D/ACxS+ZkZswZ80E4y1Gcpy5KK4NwGRhX9UjKVAAlS1KLgOGSpRYuRQV714lXoxq1aFmvf2GrX2IgJTd3ry6AW9tXNeVC4hQTLVMUWQA5WzgA0J1DWOt63gMlzzzVoDWDku2ps9q+VNdGv3Q2scUaOWsTVVNKdKgPzNKmKjxf0iYVH7F8QaggZ0N5rRvZjp5xV8f6Q8VML4cCUNAUoWRZ2JSNttthFzaZ5Fzl1VRqGXsM+ieekyVmxMsEEgg8tJTRXjISHYAaW9tdYSXiZs+aJ89br1oA4Ayp8IAFAIXUabe8OYsnfkGA6BN9lQWY6SRtiTlzsmeIMGQ5VLSNEqO9xMP0IQxc4DUbU+UNMRiQQkguCCCLGlB7i/ti+mab3sl+1ZGkFoOa9QzUgKchm0Kqk6UNzQG9S20cQ4yi4FXqPvVLmt6mpJuBpgmD9JPEUN+uRlD90ypepJqQl7qJ84t3CvS3LUAmbIUkkEGaFhheoQJZ/wixfKHip1M8aJaJ2nVaYhNhR3BNc1HN+bmj6h9GJcZh0zEMsAgsS6iHbLYu7UT1fmYa8F49hMX/4acJrULIWGHeuFAZfCfZrSJMS66hqWZycp1r+FTqA1GbTyVuRCzDtJ6MEK7+EOVjSWy1k1SPHMmtoTzBoC0UJc6bImrk4kZVpu5S6SwLEJJ3j0WUi+2jF7Zqsa7+cRXHOz8nFS8k9KjQscyk5SXNfVkZgGAfZN6l7d4Hi0g+PFWU80tM/HCfhwKxRM1OUKBGU2OnvhliuKZkhMplKzKFqgUL9HOtLwt2u7HzsEohReVdK3QnNYEhPrFEVLeUDhRl+qZADv3n8TtYlvhvHd1FC3Ge1y5fFPafaU9e/ctIZzPH/AB+ym+F4fULmnMupY2ESUtAopQch6P3a/Hp8Y631pDDiHEQjuoGZZ0Gmz/KBw6SZ1h/pNHRU1HFd+nmSfmSneN4gE+I5lEBISLnYAaCghPDySTnX4rAaJHLc84RwGDIPrJhzLNa/Z5CH8ReWs7Lfifp4K2nZJNaSUWHut5eJ8fDh1VWwk+YVsVnvjIolZAZRALnax8obLlkEggggtW9N4WWuWAMgKjlqVMA9GZIJtzNdoAStdSkqcuSXL9SY2H5UQ1A++i+a2klPEnzTar+3WCn8N4kVcLIJcghyxTr7bQRGEeYmUgOpRSlNgVElgmrAOTeAn1bD2Wm6vdRyxtxPFvmhwvh6p0wIQHJIFxuBqRvGtdk+z6ZCAwdSwHW5Y+EgJDqTcir1sxDgsuzXB04eWNVKAzFyLiX3QyyKVqL6aPa5NlWLqNkpc2Bode6b0uWKRCipqTIbDRFwU+DtO1+ScobUVLgB2d8ymYl6VoxZlM4g81YSkrUyUi9yyUjU+W3LoY6tfa9XPsem1vYM3KlNhqC1K7e93pAKLVE7RekWVLC5eGAmrCW9YTlShVQe5MR3ms1u9yjOOLcXnYhZmTpgUo6uhI5d1LCPQIPw5VN7k8jV9qwOtD/Vg35OwrWxTKhrBYN+/JCSU73ntO+/NedErGwt95Pzg4n8h/Mn5x6JSTYB7/d5NcbN7xSkKylCjFhezlgHd1E1bTpS7y9oaeHqvbt7BkR5LzyjiDaDzWmE52PWbEJHJSfnHpdA+8GGYsaBJN6ZTUEE3JDAUBpBwSH127qasa0I2r5qoQAB0SsBvhUnVFQRhx5Ly4cOTqn/AFEf7o6cMaeH+dH+6PU6ltmYkGj61J0DsKNVgKjmIUCySQXYCpoBcvq9A3k1S8W+2eH35ITcHn9+a8sIltYJ/wBSX84MuoYhP+oj5x6nSojWjVPxv9e4wZJLpeh+T6Atfr8ob9p4Hz/hWAPAtceS8qpCgQpJAI2mI/3Rf+zPpPnySEYsJnS3AdKpSMoJqSJaSVVL+UbahZpc12HXXS35GOjlW1L6DWvMx4ztIsW/fkqxE4G4P35phwviUnEo9ZImJmIL94BQu7eIA+6HIrazkE5tiXtq6WuCCDYiFiaV8jQaHYjntpYwU606U+d7/wBbQMbcFcCmmNkJUhSFjuq7rOzuydxuaC9OQjFu3XY+ZgF/pEkvIJY2aWVHuoJWsqW4D5mpG5kc66i+g0sKNYM59rbFSQtCkLHdKCFcnBBsQo67aVu02PtkdF3MOxNyI0XmzF8XKgEywyiGO4JuBv1h3wrh2TvKqs06bxJdruz/APZ+KzAPLVmKA47qcxsStSlMzOWP4klrBAILginnEp3btgbGLA6nmtDsgtrJTNO6726Dl42/dGhhxPH+rDJ8ZsLtzMK8QxglpfU0SNz8ojuEYYzFGcutadd+gsIqgiAbvZO6PUpjXVb3SClpz2zqf+o59eSfSsBLRZLv96tB8I7OU35Wg81W3SGM+ZWntFLRzE+Q3cbrku6gbhjaB0SGKxRSNK+47sYuXYngqpKDPmDKuah094OZSxLWlXdUyXKVbKHKKz2awH6TinKsvq2mHUqyzEd24Z816xpaAEgAUAsAKsGpvqOdoIkdu2YRqVlnOM8pedBonOGl6gsz2qaMRR9X11bzlEjKAVE3ZklShUAkgJuzliUg0FnrFSp4QhS1FkoBWokOwBCyWAdu6rmW0LNlXbLtD+lziWAQnupDCuVS2X4QQ4V4T5uYqghMh8FCom3Y8VtgxADB1GpfuTKUP+E72pcnQCB69O6r3yTOY+64p8Y85et5D2J+Ud9ZyH8qflBnsDeZ+/ghPbH8gvRZxKS75+Xcm7JuyaWtWw3jisUli2eunq5uos+QtchwNo86iZ/hH8qflCqUHUAf5U/KIuo426kqxlTK/QBehlYtD1Kz4rypxFa2KDQtUDfzhdHEJYPjmNv6uc9cpNkObXcGnNx53yD7o/lHyjhlpP2R7orEEfipvM1iSAvTOFUlaQpJLDO1wq5DlK2Ne8O8CHCTW5cJS4DkE+IDNQ97M4FAbhqUcVFzTfRQpuGSP4p2jgDOonp4aE0v53Ml+7mKi4sAwyqY2DO4Ny+1QGoeLOIUWm4uu5Wo4uS7gUBd9qs5FB4zTRRMt6A3P3nNyCL6VtYjTUpVq7Am5bU76vmDdN4ALglyzbM7VFxWIqSiU9q8GXecWoxErEBxfSWG9pp5x3/ivBsWmmzAepnt5kS6C1WJDmPNCJbgMA7codS5AAqB7B8oMdDG3UlVRtlk7oXpD/izBfvlf6WI/wDraO/8W4Nx+uLN+6xFDS36uuuugu8ecfUp+6PYPlA9Sn7o9g+URwReKu9mn8F6OHazBfvlf6OIJ/8Abf8ApHE9rcGzmcbk/ssRWpNf1Y+FH5PHmyeUp+yH2YQ19Y+g9g+UWNp2OF80NI57HYTa69T8P41InqySVlavEQUTUBgUucy0APYtr7w7VLG721extUuNSOadI8v8MxSpExE5BAUkpNgXYhTWo5Aq1I9E9ke0CMbhkzkklSQlM0N4VsFEOUpCqZT3Q22sUSxBou3RTa43s4Zo/aHhKMVImSZgzAju98p/WALyHuqGqxQkg5g9q4LPScHNmyJn2FKrSpFAGBUzs949GrW1Ca7NW5ewJqx9sZz6Xez5myUTwSpcsZGoBlaZMJJKgkEP4Wc6UoOREO/LdoVcyZ9O8Sx6hZHLC8RMrYXYUSOUWWWgAAACgYQw4KhIRQup+/u+0SH1WIVk5e7ABYDQLXbFpQyLfON3vzJ/ZR85TfGnyiMxc1gdXp7dYbYniClPprz9sPey2AVOxUsJrkUla6jwpWjNc1vYVgplMY83rOVu1GzHBEr/ANkMEJOFQnPmE0CcQwDZ5ctwxJzM16X01mjT3gVpypWvvqdmjiQwpYBgNgBzJq3R4SxmI9VLmTGzCWhSyK95hmZ6s7c2BEBOcZH35qDGiNluSrHpF4ypCUYYBiRnUSQSUq9ZLKWy93wgu710jPD5Q7xc0zp0xaRVa1KYaZlFV6b3MPMHwV2Ky2rD8TDVjo6dvaKCipZ6x/5bb/LzURLlk0AfpD+RwlR8Xuifk4VKAyQ3SDGX9WgOWvLsmiy0NN+HWszlNzy4KJTggKAD4FhHFSGv1r84llyxbyrCS5X1cMIHExOqOds5rRZoUQuW35QmRQ/WsPMWoAOW3+URn6Q5YW98FxNc7NIK8siBbfOy3P0S14ZJDgHNNbf9oQWpT7JvpaLeJrAizf46gqUwqQebB/ugO4aneip/7MkCjZp58wtQqdKF9aJVSgMXNiz+EByQxeqiSNNBUMQWB5kaXvlAM7oRpmpfnfK1T4iNL0bVTwcrBcOHZ7jctRuV93qWhNjrcq6tlIf5hTDxJ5mDsWNQX2BsTzPQlm3iA1Ul5i4VLdJ/y/jEgMPDbgA7quifxiXYAPFlQ8iQgLSbJp2upGuPj8ymP6PEdjsUEulJci/LpzjvEuJZnSjw7tUt+ERyUElgL8oLgpjbFIle0K9hO6p/P6IoSSdyYkZGByhzflElw/hoQAT4tWsOQhWdKimaqDjhboiKTYzmM3kuvLl/KhyIsXo846cHjE910TT6tnAYzFIGd8pNGBy0By6RCT5cMFzRmG41iyLtZJdXx4BfiF6pCgWP3gGqRSrMk28Q0fwvyb4mUJstSXDLQpJYv3VJIdw1nLVsbxWPRZxY4jAhIDGQUSHuCEISQaBLa0cs16xbC77gC1Q5cPfVwbg+IVDlxHtwOIQ7TibdefOIYX9Fxk2QaS/WLSjV++Qk3JqBqYczJgSCTQCpi0+mHhymkYvRARKykM5AmzNwQzGmX7RFGaM64tj8yUpAZwFK16D65Re6AzvaRx1TnZu1BS00jXHNvdHVQwEXv0c8PovE6OqVcO7Spm72fRucUVEan2LwJlYUOw9YRMFXoqXLuxd70oavtBlY/sFZ6mbeQKdL+46k6DXy/HWKz6QMQBIShKmmKmAZctChSZyXzGgcuGFQOoizAD29XLNW3uraKD2yGfGy8pfJLRmozZZkwKA3A98LqcdrFyTKYFwDBxICaYLDBCQGYsH1c6w+SISlwrAr3Em5W2pYmxMDWo0FP08deI7G8WQiie8rZ6DqY9HE+Q2aFKpqoYGYpHWCerUEgklgPZWIfH8VZxLrTxWHsiOxOMVMPeI1ppDYnpaHdPs1rRikOfJY6v2++TsQCw58f4Rp8xSiSouY5IvBT0hzKw7VN4ImLG9kfeaQhr5AXa81uPooWf7Mk/xTgzn94WNaDXnboblVtiGAZZLd4O7Bm7pvsQ4cmKT6Kpb8Nk912VOc8itQ1SQDUhxVlG7RcUKFSakVzEKYZjSjlrhy4BYswslk75RjO6E5JcnzA7xFyR1BqPbygZjUizXzKa5JbcMemmkJzQwIsHdy5cAjZlE0u5olNwTCjBiAObVrUhySKggHTzsYgFNeZ+DTwhClKLABPXX2w2x2OVMLWSLC3t3MNT4R5RyWnMoAB3NobMhYHbw6rntsroG07dPncoIQVEJF7AdYsvDOHCWHNVFhuB0jnDMAJYBPi11A5CH8L6urL+yzRafY+yBCBNMO1wHL+UGhKYPnWFf6RH8Wx/qww8Rs+g3gONjnuACc1c0cMRe85BR3FsRlOUX15P8AjEQkVjqlPU3NTDnDSKZj5Q6DGws8V8+lkfWTE8PkFdPRLxEScdlUe6pBlihfOuZJSGIBOg5Uq0blVmIuBTMely1LWHlt5q4XMKcTh16JmyiT0Wkx6NweJ9bKlzwGC5aF0fu5glYbMkECz2qgUDlhKgXs5Ra3A5zOShO32AE/BTgT4UrmhlFQJRKmFILMEnvXq4OrCPPEy5vctHpTiMrNKWkeIpVLzd8AkoIYZj3RX7StR54Li8BlxsyU1JcyaP5JiwNeQi+jmwNJPBcdCZJGsbq7JR2IQMrCldI1XgiycNIJJLSJSR0yAhI9opz50y6bp/EI1Pgrfo0j/wAmVpf9Wj23+G0DzH8sdUWAN+7oE8UL0LAblrda/hWt4z/iHCsR+kTpgQ7zJgAo2UrUQY0AnkLH7J2Fn8/oR19ujsS2mnk/4RRFLgvcXurHsJIc02IWfJweJ/cj+aFBhMTrJ+vbGgy5nPLcPUFiUi97H21sKycqdQkMzpJZKmHhrsGY8rWqYlvI/wDp6q72qrH/ALT5BYzxrD4hKHUChLENSut3r0ivP+Gka16XD/y0of8AdNNQck0G5NKD37iMkX8oa0Ugw3aLJPWPkfITI65SkpJJAFSSeUPf7InfcMJ4SURU86eUeh0LOUV0Toahms56GlhHKmscwAg6+KjDTl5IOVlgcnh85P8AdV3jpwE8/wB0fJ430zDzN9Fe7ehbm5rSB6w6KPsUbU01cW6UheasE3Lc+qN3MmHBjy6Kt+jVBRw+SFJUDmmu40zq0U2uXe4tcXAF7Zi9QpzYqoSSzPQggEEKUCDq0TMu/MPUM7CpfUECxdgdgV0TQxLBqOMqqh6kswepfSpVoXoL8RJXjHhaAnAN7jMQwqLGvOjqpQ90tZyqAanKoE0AJLVNNWqaP3fsirCE1TA5dgRmoUqbMVH7NdUAuGq5FyArm7zEaJrlUC2fcnRxXRnaof11Cy81y+AYgoSfVKtqGb2w7wfCMTLc+pcnUnSPRsqc7MXJqSEqbnUU3atOccEwkB6OEuMqg57xIrzFiHFXvQt1UHDCRl1VUTZInB7HWPRYAMNi/wBx7zCInzBMEuZLCTXWtA9uhEeiDNNK0dvCob7nmB7d2jEPSVOCeIzVKsCP/j4feINZHICA2xsmMO06tkrccl23F8goTHY4S0vrYA6mIXB4ZeImZUgqWRYB/oVENMRPK1Od7bRd/Q7TiIP/AGJvPbaCYo/Z2F3FDbR2i6skA90afVR47C4t/AD/AJkfOHSuyWMP90n+ZP8AujfSqz7uzGpoQWcsKP1bWOFZ1DhvuKcVHtsDRjQFi4ih1Vj7zVTGHxghptdefldjcYbSxQv4k301jZ+zUtUrCYVC3QUSJIWdjlSBflmqAWY1FjMJmVJBqT91Wtg40qTcgOTSGq53dc92gqAUvUk0e7h2amY3ckVyS4ha1l0NOLETdNZxNAQrTUnRyPezMQWSaEBsR4tKbiOJf95NPtmKMbWpVQwDOKBKgBSjbWHSgo4jHOOn/qGI/jXp/jmaRGHNr+n7o2Btp4v7lXJmn8QjUuCn/lpDP+xlW/8ALFv66AaxlGImi2satwVLYaQDl/8ADylaGikBnb+E05RZMDux1VIeDUOtyCfN7/k7b+x+kNp/EZaDlVMYtzJ2q1jS3P2uGrpY6b6Nr8LVpXMe2uCErEKNP1n6yjHxrmnToIhTxNkJDl6oldGAWrQhxaSLTB7FD8PlbnDyRx7DhiZm9MqiQ7WPQkOGNH1aMR9YRaHeGlLVeg98FPpYmjO6HjnnldhaAr56R+NSp0iXLlrKlBZUe6oBimYKOKVNnLPsz0iXhgkPc36Q9lyBtbmYE1EUGRoGFmiawbPeCZJLE8LJslQ1OhjZE9qMMB+0LsBRKhoRtet322jG1y9WgpTyiZ3b2gOvlyQskEwkc5ls7araT2owrl5pND9hepreoFBT5QU9qML+9PPurr4bsBt8RaMSnTAkVENZanNhHW00Tsxf0Qss8seRt6r0Vg8UmbLSuWSUnMxAIqMyS9KVfQOQLvDpKtb1dr0clxVhcMaFiIqfozV/06TbxTbt99RuehizqHQ12OitCdXBtV2NdQHjC4gIthxsBKeBZDs9CbBrFJdILBqOz6q+7C6EsClz1YuWJB3Li7kHwl6GI4rdx3dBUblw4TcnMLnXR3LhEwOSGsNLsXD+R1Yu5q9OgqpzLKEHpEwChWctj/2ppDV5AG7VGnOh/wD8hYAO0xZpRpU0V/lPt2NqB8GwksFNtBC4lDYQa6OIG2aqjime0OFrLc0ekHAByZyyWb9hNp7rWoKfGMm9IXFZWIxMxcokpJDEgj+7kp+0AfsHSKzNnV7oZoTmTCbwRFE1uYuhZC69jbLkkouPoz4tKwuNTOnEpQJa0khJUXLNQVirYTDlR5CH5RHpZG3wlXQ0cj24x8FuJ9IeBFpsy/7ma106FOwqHrXehVdv+Hsf10yoAf1M12H+IhyQSSCXjDFIG0EUANIHDIvFWmGYa29VuU30g4FT/rljl6qaQS6jsN9iLHSsxKxiZiJc2Wp0LQlSSxSGOUjNTZqOGBVSjjzhhk51pSPtKCR5kD8Y33s5LKMLhkEVEiUCCGIIQkah6ZorqYmsaCFGmcXuIKfoBpdw16kUataauxqxjHeNKH9oYkbLmabLX842BIFKjQuxDd29agNtar6kYrjiTxLFOX/WzzfaaoC0VQ9x58EfEf8AkxD/AOlV5BqPIxqXYfGKm4YAkn1a/Vitkply6A9Ta29DGVpi8+j/AIge/h7oAVOapGZpctztTXR9oZVTbsKT0zsMoV6PTQ7bD68opfpF4fROIcNSUQ4dwJy3a7c/K4i5itacmb5l6e1rWiO7Q4JM2RMSoEqSha0ZQCTMCFBI71WqfDXw0rC6ndhkCZVDcUZWb4PhwYKNXYjYRIIkQXhYOVQVdKiG1AFLaND/ACRGokfjIctJsylhMDXsGoTcS/owFSoctHCmKMRTQwNsmJw/0Ij8dPSmgqrbbrC3EuJs6UMTYq26RCrrr7bwxp6dxGJyy206+NpMcOZ4n6IkxRNS8Gw94IoQfDisHEWyWZdc3JW1+jL/APXSes3b94fxY/Qi0EMLbVoSH6ivxYWMVf0Zv/Zsr+Kb/wCtW1RVvfFnLbADoNCTV7WDhnBF7Qkm756pxD+m3oukcqDMaNZzSlDUKoW9og2arM1tB96/w8lamCLpUjWxtcaigN69ICE735Ab7PZ+Zu9KxAKwjJYBwlDpPQfjCXEJ48CehP5wnh8SUIIDOQKnRnt7YaiHDIC6QuOiENWG0zYma53XD5weRKKlBIDkwQ+Vt4sPBcDlTnPiVbRh+cWTyCFl/Jc2fRuq5gwaceiUkYMJS3mXu8BWHiQIgikwk3hJutz7ExrQ0DIKMmSIi8epqb/CJvGKCQSdBFbmLKlEmD6RpccR0CzO2XNiGAalS/ZDBKm4uQlAPcmS1lgSQBMQ5psDeN7d/YNubWrQZg+zEaxmnol4VVeKND3pYBF39UsEA3savTzjTGtt+YcBvOnS0U1j7vtyS2jZZmLmmfG5gRhp6iD3ZUwuwd0y1Ev7NN9GjF+HTfWKmTSBmWtRJ1qcx+MaR6SeImVgTlygzVCWQPuqlzH1qKUoIznAJAQlmDgG1yY43swHxPyTGgbjrATo0fNVkCJngGLXJny1BRS6kpWbAoK05gdCKBwaRz9ECBudzeEZqaa7/lBpnDzlolr6B8TbnvLXZM3MlJFQpObSoIDHmNNrk6OqBs+ttOlvoRX+xvEBNw4ByIMtkMCyilCENMUkmtSQVUH4z5A8msxPXd7N5HeF0jMDrImN+NoKoHabB/o2IM5IUqXM7ylEUClqmKUlJAZwA7GrGDoU4BGoDPzrFt49wv8ASJJlZmLlSHPdz5fVgqcFvEASK0HSKFLxBkZ5c3MFIUprsWOUBLs4cFuUWSN3zQ5uvFMNk1opZDDIbMOY8OakFrABJLDfaIDiPFM5ypLJepFyB8Ib47GrmGzACgHPXnDUPbmBW8FU9GGdp+qq2ntp0944cm+p/hc19pqI4W93vg5JtW+uwgSpZJADudvlBxsGklILEmwREyybB7Wh5Lk5Qd4eysGEJ3Vcn8IQm6wCZsbstEydQmGIufrbyyWsejMD+zpL/em+TLVWoOj+2LSXG40D9epvprfUxVvRkP8Ap0nd5urfbU3xIp97pFoyi9H6Nc2Lgs5NuZobQvm756rsP6Y6IHVhV9AK1qfhq9NwDHS7kGwa7Xfbzevkxdgoc9TdzY0tazV+62sAJFgzBvKpG2tfdfSAVh0Xm8+EeUJi/nCjHKPKD4eQpa8qdS3TcxoWuDW3KTNY55DW6lOuC4LOoKNUpqeZ0HOLL9VhPDSQhISLDe8KQhqZzK+/BfRNl0DaOHD7x1+/BAwRZjpP0IZcQxISkm+nWKmNLjYImombEwudwUVxzEuQgHmfwENeHYNU2aiWkElSkigqHID20eESSoklySY1H0Z9mEhBxU0HOW9WlSRlKTkWF95L5nAZQLDd4dHDDFb7uvnU8rqucvPH0CuXZ/hgw8iXKCQClKc5SAylABJLsCpmFSBRLNeH6dHFWuKlraDXu2YUekDKHqQ1BXk/lrcCne2pFdoeJpkSFzSoBWQ5DmbvlJKdQTmyg0eqCN3U5vd4lH5Mb4BZ56Q8f+kYxMlBdMoNMBIbMlawqxIsW82pEbLAADUADsKiGWABmLmT1OFLUo8jmOYn2xIqZIKtBUtsIvndmGDgm2x6e0Rmdxz+Ca4lER8wRMzZcRmIlxGJyur4OK7wXiJw88LFQpkrJeiFKS5SQaEM4jUpM8KSFgqIIChaoICgxNDRW7eymQq2p5xa+xPGVFXqFqDsyCo6dxCJSHVVi5CBuWvBEjN4241Czf6MmE6FXf49eYP1111rHa3s564GZKSfWJFUgNmbOe6lKCpSypQ6xZEzH1apGuhAN3tqzN5Ex0FhSjGmV+6xDZctmIozVYOIFjeWOuFfIwSNsVis2WUkhSWIcF3BcFiC+r6QQkM22h5xpPbDs2mckzpSQmcPGlIATMACjmZKSpU4qNdDSM9MlSTlUCkhVXDVFKuIbRyh4uEtLC12EpOXJJLJSSbUqIsWBwAljQqNCoQfhuBEsPdRqSOe3KHK4XVFUXnC3RbDZeyWwN3sne4eH8phiojplj9axJYqIybYx6DUITavdd0K1j0Zrbh0m7vNttnUba1AFN+cWo1cVNgSWFi3Ww2Yg3q8VD0azR/Z8oEt3pjbHvkEOX0L0a2uloTNobMLM7eJlEMXDP5ZgHDEmmUds9Uqh7g6JwTe7cqsH+He8mO1OA6kEciRu+hZ9Pd1TmLFS9jr9lRLUYX5O9W+0DB1LqRqz6n7RFzSjN5GiYrCsJXnA+ERYeD4LIMx8R9z6RG8HwoWQSzJYtvtFjB+jB1ZPlux8Uw/D1AD/wAh/wDj+5QjhMcJhGYuFwF1qXyBoXZsyK/xTEZlZbgfH8ofY3E0IFTZtREz2N7HGe86c6ZKam4UvXuBSCFS/vK5wwpowwYysjtmu3h3LD1Q7CdjziFCbNCkyUkF2PfLgjLmSQqXd/ONaQkIT3UZQlICUhg1bJCaBmAGhYDQGEpaJaEBKAlKUsycuUJIZmAAy2zXe3klOxjCpbMmpD9C9ctGZ2PhtWKZpTIfBLoYt2PFLTsUE1cnb7rAlzmLAuwo5PepSsZX6QuNCfMRhpRWUIP6x6/rAVgqSxLgJU2YgG7xYu1nab9HQQjKZswFIBqyVBSSTlKTnDuKUJih8Nkmq1VUou5qpjU5idXiyMCNu8OvBTZE6pmELdOKfYaVlASNA0N+NzcsojVVNuZ+Hvh9LT84guOznWEv4U7an8mjlFHvaht+q0e1JBTULg3jkPj/AApxY+hDTFpu7edIcz56UgqUQ19jy6xXeIY4zC1kg0D/ABj1JTPmOWnNe2tXQ07bHNx0CQxWIcsm0FwuIUhQUklKkkFJBIKSC4UkiygRQwiRBYa7rALBYaSV0jsTlpXZftF65OSaoesTUFR8bBIDuoqUsmtNotSQaEgjkw133Z2oa1jE8NiFJUFJJBFQxP4RoPZrtGJyRLWwmUCdl+EZQ6ypSiwpr50XVFPbNqNp6i/ZdqrYx867Uvfk/WpGxMQ/GuzUmelXdyzGJSpIQkFZNPWHISUlzUVdolkl9QWcPXQq/OOpIehFwKWe56V+DdRWPcw3CLexrxYrNsVJxGGUEzEFaH8YSsuK2UUgaWg8nGoWKFjXuqYKjQ5kpBAzolrALhMxAWknR0qNXcOHcua6xWeKdjJSnVIUpE1ySCUCWAbBGSXmFlX0bmIu/KkzOR9ERBX1VN2e+31CreJiOmWP1rEnjODYyU49UqYE1KkomrG1VBADVaIecouBlUN3BBi6OFzSFTWbQjmYeBtoVpPYKaRgZVaPNuHHiV72JsxpesWj19HZtWAAuo2IB0cUNQBQuwqXYU/8lK6zB/8A2o+djSJ9VNgaN7fhTpQaCBJe+eqrhH5beils5BIoS5ejnulPuNGuRnYOE1Vcsqp0JLAUJbQACgBqKgM5akNmNvLXm/uV7+cHl4kvQhqW3Bf/ACu55uS7iIKZCyTgB7qv8v4xL54r/DcTkTVKi4DMHs/ziQlpxMysuSsp0Pq5ptfwpIvBU0DnyE8Efs/asNPStYTnnkNdSnM7EAXIGt2+MM5c2bNITKlqUf4FFXUBIMT2A7EqK2xE0ED7inVt/eSqCLbw/AypKEply5YKQ3rChPrFucx9YpKU5rtpSmleWij8T6IefaFTUZN7I9VC9nOwqUgzcW+ZxlSzpIZRPrRMlu9KARcETQhKQlISkMyUJSlIDk91gaUDMRTK9QRDIzXdjQu3QAhnF925v0IrSwJt15e+w05NFUkrn6oWOJrNE5nTyaeKuoD3S5FtANyxLREcY4tKw6CqaSSR3EJKCpSmOUlJKXQ7ZiNHEDinF5OHQTMU6gCEoQUlbkd05SoMgEByNIznEz5mJmesmmmwJyjlLclkxZHF77tPmoucXu3Uebj6Iyp8zETVTprVJIHeyhzQSwolkjSsSMpHypCciW1gw5Q6SIpnlxlanZlAKdluPFd6/TRUZ8zOtSq1JPyiycWnZZStz3R5390VVI+B1hrseLWQ9Em/E9Rd7IRwzPxTjFYlUwuo6UGg6QgOuo0jtedoFedxDtkbWANa3L78Vl3yOkcXONyUQivt0ghEK156wJcpSiEi5gWdoAJ++HivNBcbBJJS5pEhISpJBSopUDRQJBBGqSLHnDyVw/IObVMJzJTQodUAu7KdN2Y5jPzBn8lYeAdqVFSZc8tYBZttmmqWokDXMGLgdIumHxaFh0KSoVYgjLerKSTo/srzyVQ36Q44fxOdILoL6BJKikVd2BDGl4rfG2TMZFU/mQ65j1Wrpvq5ra1gBofbWp6R1Qcf0fqxcWb5aRVuF9rJSwymlkCpWUJRZjlcq3NG2ixIngpzJqhjlUPAcru6rFnS/ecatqM+JzTmFeyVrxkU4NiNDQjQh9a1qNdqQxncIkKd5EpzRxLQ9CLEppZvM9YeK3YN3uuj08q1q0DLpqxv5DbmatqIi1zm6FScxrsiFA4riUjh6ESQiapPfZgk3OY5qpH2xpakNP8AjzD6S57/AMCOeyxEf6QvEjot23eV+cUyXmJYQcIGFoceKAdNIH4GfBab/wAdcOZijGjllkH4q/O20KI7bYFZCZaMVm0zplZQzk+Fb2BEZyUgaDzEL4IfrEUbxf8ApVHmsjdlZTkE0YxFy0vCcBw8tJl+olrfLWZLlqUGJPdVlF3Y75fa+lygAyEhI2SAlqk+EUfrqfKDzLlru3T4tvbl0LTyAflr7r6/EQC57nalFtY1ugXUMwpTpRq86U/DpAaof+rtcmv0X5AJ5WqN3H40u/ziG4n2mw8lKTnTOzPSUpCynKQBmGYM9SKGnSPNY52gXnSNZ3ipr8A+1GfQmlq2ir8a7Wy5YUmQQuZovumU1SqqFguxAHSr3is8Y7WT5wSARLAesnMgrcuTMZZzHQcor7lRAFH9kHRUgGbkDJVOf2WKUkzFzSZkxSlGwzEnr4iYkZMluQsGguEw2UAQ8QmA5psRWu2bs8RMFxnxQQmFBAaOvApzT1rbBQXaKbVCP8x86D8YhknpY6Q6x84rmKOmZg1mFIbB+djGtooTHC0Z+XRfMtp1G/qnv4Xy6DJD5bxx+Wo1g3sttBpMoqOVNSTtBT3BouSPRBNaXGwGa5JlFaglIcknWLLw/h4lp3Juflyg3D8CJQ/xG5bXlyh20ZitrTKcLe781u9j7GFON7KLv+X8pFcv5w1myIkGgikQE19k2lpw4KGmyIQVLIiaXKhli0hIJNhtuYJZJfJJqmjDAXHRRU8gCo9msL4Ljk+XlyzVskuEZ15K37uYXiOnzMyn9kJQzYwhuayE7w592q9cL7cqCv8AmB3P+ylOcCtvWKbpQs58prhnayRNLEmU7VmerSkMDWqi1ttU84yzNCgmGzxW6mYeC82olHFW3tpxCXOWkS1hbPVJSRXIzMeXwiKw2Dyitzd+UE4RhnOcgUs413iYUiBZ5rWYOC0Oytnl7TPINdFDzUQMKtKVAqsM218qt+ZEOp8uGcyU4b+sdhkAIJUK+lc5pa1aFxLtZh5RYKM2t5RlqB8JN1PVzporkYhOIduiUj1CGI8RmpF3BDZF01vyisoksGu29YZ45THKKbxNjIy6wHml80c7GYnut0UhxHtHiJqiszFSyfsy1LSgUAonMWt7SYh1LgoDx0/TwWGpaRfMrkSfA8LmUVaJpvU/l8YjYtXC8PklpDVNS25/JoqrH7uOw1Kb7EpN/UgnRuf0+/BOUpg4gQFH6MJNVvrBqBP0Ya8Qn5EKOwYNZzCxV89wwiF43PolIIrU/wBIJpYd5IGpbtOr3NO9w1tkolP47xwdNDrBgeYvtHAeY10jYAaaengvmyN/tiS4H4l9B8RAgQLtH9A9Ew2V/Vx9VYo4j8TAgRjl9P8AeC4q/kY4rw+UCBElWeK4NYh+P2T/ABfKBAgml/VCUbZ/pHffFQRv5mC/KOwIeFfP1w6waBAjx1XgrRw79mnpDtNoECM/J3ivpNH+i3+0JnN06Q1m6wIEWsS6oSkuITEftD/EYECC6XvpPtb9NnVJjToYUm2HQQIEGjVJPdKKi/nFzTrHYEAbS91aj8MayfD91xVxHD4T0MCBCwLUv0Kb4f8AARCca/aH+EQIENdmf1I+PyKzO2/6IdQmXzjg/Ax2BGp+/ksUv//Z',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Effervercence',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB600FF),
              Color(0xFFD9A2EF),
              Color(0xFFF6CECC),
              Color(0xFFEBE7F6),
            ],
            // tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
