using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using blog_template.Data.Domain;
using blog_template.BLL;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using blog_template.App.Models;

namespace blog_template.App.Controllers
{
    public class UserController : Controller
    {
        private readonly BlogTemplateContext _context;

        public UserController(BlogTemplateContext context)
        {
            _context = context;
        }

        public IActionResult Login(string returnUrl = null)
        {
            if (returnUrl != null)
                TempData["ReturnUrl"] = returnUrl;
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(User user)
        {
            //authenticate using the manager
            var usr = UserManager.Authenticate(user.Username, user.Password);
            //return now if the user object returned is null
            if (user == null) return View();
            //otherwise set up claims - one for each fact about the user
            var claims = new List<Claim>()
            {
                new Claim(ClaimTypes.Name, usr.Username),
                new Claim("FirstName", usr.FirstName),
                new Claim("LastName", usr.LastName),
                new Claim(ClaimTypes.Role, usr.AccessLevel)
            };

            //create the instance of ClaimsIdentitity (holds the claims)
            var claimsIdentity = new ClaimsIdentity(claims, "Cookies");
            await HttpContext.SignInAsync("Cookies", new ClaimsPrincipal(claimsIdentity));

            //handle the return url value from TempData if it exists or not
            if (TempData["ReturnUrl"] == null)
                return RedirectToAction("Index", "Home");
            else
                return Redirect(TempData["ReturnUrl"].ToString());

        }

        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync("Cookies");
            return RedirectToAction("Index", "Home");
        }

        public IActionResult AccessDenied()
        {
            return View();
        }

        /*        // GET: User
                public async Task<IActionResult> Index()
                {
                    return View(await _context.User.ToListAsync());
                }*/


        // GET: User/Details/5
        public async Task<IActionResult> Details()
        {

            var user = await _context.User
                .FirstOrDefaultAsync(m => m.Username == User.Identity.Name);
            if (user == null)
            {
                return NotFound();
            }

            return View(user);
        }

        // GET: User/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: User/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(UserViewModel newUser) // add await after this works
        //public IActionResult Create(User user)
        {

            User user = new User()
            {
                FirstName = newUser.FirstName,
                LastName = newUser.LastName,
                Username = newUser.Username,
                Password = newUser.Password,
                AccessLevel = "2"
            };


            if (UserManager.checkUser(user))
            {


                try
                {
                    UserManager.Add(user);
                    return RedirectToAction("Index");
                }
                catch
                {
                    return View();
                }
            }


            else
            {
                ViewBag.Message = "UserName already exists.";
                return View();
            }
        }


        // GET: User/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.User.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }
            return View(user);
        }

        // POST: User/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("UserId,LastName,FirstName,UserName,Password,AccessLevel")] User user)
        {
            if (id != user.UserId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(user);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!UserExists(user.UserId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(user);
        }

        // GET: User/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.User
                .FirstOrDefaultAsync(m => m.UserId == id);
            if (user == null)
            {
                return NotFound();
            }

            return View(user);
        }

        // POST: User/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var user = await _context.User.FindAsync(id);
            _context.User.Remove(user);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool UserExists(int id)
        {
            return _context.User.Any(e => e.UserId == id);
        }
    }
}
