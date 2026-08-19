using System;
using System.Web.UI.WebControls;
using P2RLS.DAL;
using P2RLS.BLL;
using P2RLS.Common;

namespace P2RLS.Pages.User
{
    public partial class RewardShop : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindShop();
        }

        private void BindShop()
        {
            rptItems.DataSource = RewardItemDAL.GetForShop(CurrentUserId);
            rptItems.DataBind();
        }

        protected void rptItems_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Buy") return;
            int itemId = Convert.ToInt32(e.CommandArgument);

            var result = RewardService.Purchase(CurrentUserId, itemId);

            switch (result)
            {
                case PurchaseResult.Success:
                    litMessage.Text = "<div class='alert alert-success'>Purchase successful!</div>";
                    var unlocked = AchievementDAL.CheckAndAward(CurrentUserId);
                    if (unlocked.Rows.Count > 0)
                    {
                        var names = new System.Collections.Generic.List<string>();
                        foreach (System.Data.DataRow row in unlocked.Rows) names.Add(Server.HtmlEncode(row["name"].ToString()));
                        litMessage.Text += "<div class='alert alert-success'>🏆 Achievement unlocked: " + string.Join(", ", names) + "</div>";
                    }
                    break;
                case PurchaseResult.InsufficientCoins:
                    litMessage.Text = "<div class='alert alert-warning'>Not enough coins for that item.</div>";
                    break;
                case PurchaseResult.AlreadyOwned:
                    litMessage.Text = "<div class='alert alert-info'>You already own this item.</div>";
                    break;
                default:
                    litMessage.Text = "<div class='alert alert-danger'>Item not found.</div>";
                    break;
            }

            // Re-query rather than trust a client-side delta — matches the balance the
            // transaction actually committed, even if the purchase failed.
            var stats = UserDAL.GetStats(CurrentUserId);
            if (stats != null) Session["VirtualCoins"] = stats["virtual_coins"];

            BindShop();
        }

        public string RenderShopItemIcon(object categoryObj, object imageUrlObj)
        {
            string category = categoryObj != null ? categoryObj.ToString().Trim().ToLower() : "";
            string imageUrl = imageUrlObj != null && imageUrlObj != DBNull.Value ? imageUrlObj.ToString().Trim() : "";

            if (!string.IsNullOrEmpty(imageUrl))
            {
                string resolvedUrl = ResolveUrl(imageUrl);
                if (category == "border" || category == "frame")
                {
                    return string.Format("<img src='{0}' class='rounded-3 mx-auto d-block my-3' style='width:64px;height:64px;object-fit:contain;background:#F8FAFC;padding:4px;' alt='frame preview' />", resolvedUrl);
                }
                else if (category == "avatar")
                {
                    return string.Format("<img src='{0}' class='rounded-circle mx-auto d-block my-3 shadow-xs' style='width:64px;height:64px;object-fit:cover;' alt='avatar preview' />", resolvedUrl);
                }
                else
                {
                    return string.Format("<img src='{0}' class='rounded-3 mx-auto d-block my-3' style='width:64px;height:64px;object-fit:cover;' alt='item preview' />", resolvedUrl);
                }
            }

            switch (category)
            {
                case "title":
                    return "<div class='icon-box mx-auto my-3' style='width:64px;height:64px;background:linear-gradient(135deg,#EDE9FE,#DDD6FE);color:#7C3AED;border-radius:18px;display:inline-flex;align-items:center;justify-content:center;font-size:1.8rem;'><i class='bi bi-award-fill'></i></div>";
                case "border":
                case "frame":
                    return "<div class='icon-box mx-auto my-3' style='width:64px;height:64px;background:linear-gradient(135deg,#FEF3C7,#FDE68A);color:#D97706;border-radius:18px;display:inline-flex;align-items:center;justify-content:center;font-size:1.8rem;'><i class='bi bi-bounding-box-circles'></i></div>";
                case "banner":
                    return "<div class='icon-box mx-auto my-3' style='width:64px;height:64px;background:linear-gradient(135deg,#E0F2FE,#BAE6FD);color:#0284C7;border-radius:18px;display:inline-flex;align-items:center;justify-content:center;font-size:1.8rem;'><i class='bi bi-card-image'></i></div>";
                case "avatar":
                    return "<div class='icon-box mx-auto my-3 rounded-circle' style='width:64px;height:64px;background:linear-gradient(135deg,#FCE7F3,#FBCFE8);color:#DB2777;display:inline-flex;align-items:center;justify-content:center;font-size:1.8rem;'><i class='bi bi-person-fill'></i></div>";
                default:
                    return "<div class='icon-box mx-auto my-3' style='width:64px;height:64px;background:#F5F3FF;color:#7C3AED;border-radius:18px;display:inline-flex;align-items:center;justify-content:center;font-size:1.8rem;'>🎁</div>";
            }
        }

        public string RenderCategoryBadge(object categoryObj)
        {
            string cat = categoryObj != null ? categoryObj.ToString().Trim() : "Cosmetic";
            string lower = cat.ToLower();
            if (lower == "title")
                return "<span class='badge bg-primary bg-opacity-10 text-primary fw-bold px-3 py-1 rounded-pill small'>🏷️ Title</span>";
            if (lower == "avatar")
                return "<span class='badge bg-info bg-opacity-10 text-info fw-bold px-3 py-1 rounded-pill small'>👤 Avatar</span>";
            if (lower == "banner")
                return "<span class='badge bg-success bg-opacity-10 text-success fw-bold px-3 py-1 rounded-pill small'>🖼️ Banner</span>";
            if (lower == "border" || lower == "frame")
                return "<span class='badge bg-warning bg-opacity-10 text-warning fw-bold px-3 py-1 rounded-pill small'>✨ Frame</span>";
            return string.Format("<span class='badge bg-secondary bg-opacity-10 text-secondary fw-bold px-3 py-1 rounded-pill small'>{0}</span>", cat);
        }
    }
}